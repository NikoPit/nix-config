/**
 * Auto session naming.
 *
 * - Auto-names the current session with an LLM-generated title derived from
 *   the session's opening messages (before_agent_start, only when the session
 *   has no display name yet). If naming fails it is silently skipped so the
 *   session stays unnamed and can be retried on a later message or via
 *   `/name-all-sessions`.
 * - `/name-all-sessions` asks the LLM to title every session that has no
 *   display name, using each session's opening messages as context. It retries
 *   a bounded number of times and then reports the sessions it could not name.
 */

import { SessionManager } from "@earendil-works/pi-coding-agent";
import type { ExtensionAPI, ExtensionContext } from "@earendil-works/pi-coding-agent";
import { basename } from "node:path";

const MAX_TITLE_LENGTH = 60;
const MAX_CONTEXT_MESSAGES = 6;
const MAX_CONTEXT_CHARS = 4000;
const CONCURRENCY = 3;
const TITLE_TIMEOUT_MS = 10_000;
const MAX_RETRIES = 2;
const RETRY_DELAY_MS = 500;

const TITLE_SYSTEM_PROMPT = [
	"You are a session titler for a coding-agent terminal UI.",
	"Given the opening of a conversation, write ONE short title for the session.",
	"Rules:",
	"- At most 60 characters; no quotes, no markdown, no trailing punctuation.",
	"- Always write the title in Chinese, regardless of the conversation language.",
	"- Return only the title itself, nothing else.",
].join("\n");

const sleep = (ms: number) => new Promise((resolve) => setTimeout(resolve, ms));

/** Extract plain text from a message's content blocks. */
function messageText(msg: { role?: string; content?: unknown }): string {
	if (typeof msg.content === "string") return msg.content;
	if (Array.isArray(msg.content)) {
		return msg.content
			.filter(
				(block): block is { type: "text"; text: string } =>
					!!block &&
					typeof block === "object" &&
					(block as { type?: unknown }).type === "text" &&
					typeof (block as { text?: unknown }).text === "string",
			)
			.map((block) => block.text)
			.join("\n");
	}
	return "";
}

/** Serialize opening messages into a compact conversation excerpt. */
function serializeExcerpt(messages: { role?: string; content?: unknown }[]): string {
	return messages
		.map((msg) => `${msg.role === "assistant" ? "assistant" : "user"}: ${messageText(msg)}`)
		.join("\n\n")
		.slice(0, MAX_CONTEXT_CHARS);
}

/** Clean an LLM-produced title. */
function cleanTitle(raw: string): string {
	let title = raw.replace(/\s+/g, " ").trim();
	title = title.replace(/^["'“”‘’「『]+|["'“”‘’」』]+$/g, "").trim();
	title = title.replace(/[。．.!！?？;；]+$/, "").trim();
	if (title.length > MAX_TITLE_LENGTH) {
		title = `${title.slice(0, MAX_TITLE_LENGTH - 1)}…`;
	}
	return title;
}

/**
 * Ask the LLM for a session title.
 * Returns `null` on failure (no model, timeout, provider error, empty result)
 * so the caller decides how to fall back.
 */
async function generateTitle(
	ctx: ExtensionContext,
	messages: { role?: string; content?: unknown }[],
	signal?: AbortSignal,
): Promise<string | null> {
	const model = ctx.model ?? ctx.modelRegistry.getAvailable()[0];
	if (!model) return null;

	const excerpt = serializeExcerpt(messages);
	try {
		const result = await ctx.modelRegistry.complete(
			model,
			{
				systemPrompt: TITLE_SYSTEM_PROMPT,
				messages: [
					{
						role: "user",
						content: `会话开头:\n${excerpt}\n\n为这个会话起一个简短的名字。`,
					},
				],
			},
			{ maxTokens: 128, signal },
		);
		const title = cleanTitle(messageText(result));
		return title || null;
	} catch {
		return null;
	}
}

export default function (pi: ExtensionAPI) {
	// Auto-name the current session from its opening messages + current prompt.
	pi.on("before_agent_start", async (event, ctx) => {
		if (pi.getSessionName()) return;

		const history = ctx.sessionManager.buildSessionContext().messages;
		const excerpt = [
			...history.slice(0, MAX_CONTEXT_MESSAGES - 1),
			{ role: "user", content: event.prompt },
		];

		// Bound the wait so a hung provider doesn't stall the first message.
		const controller = new AbortController();
		const timer = setTimeout(() => controller.abort(), TITLE_TIMEOUT_MS);
		try {
			const title = await generateTitle(ctx, excerpt, controller.signal);
			// On failure: skip silently; the session stays unnamed and is
			// retried on a later message or via /name-all-sessions.
			if (title) pi.setSessionName(title);
		} finally {
			clearTimeout(timer);
		}
	});

	// Name all sessions that don't have a display name yet.
	pi.registerCommand("name-all-sessions", {
		description:
			"Name every session without a display name, using its opening messages",
		handler: async (_args, ctx) => {
			const sessions = await SessionManager.listAll();
			const unnamed = sessions.filter((session) => !session.name);

			if (unnamed.length === 0) {
				ctx.ui.notify("All sessions already named", "info");
				return;
			}

			ctx.ui.notify(`Naming ${unnamed.length} unnamed session(s)…`, "info");

			let named = 0;
			const errors: string[] = [];
			const queue = [...unnamed];

			async function worker() {
				while (queue.length > 0) {
					const session = queue.shift()!;
					try {
						const manager = SessionManager.open(session.path);
						// Re-check after open: another process may have named it meanwhile.
						if (manager.getSessionName()) continue;

						const context = manager.buildSessionContext();
						const excerpt = context.messages.slice(0, MAX_CONTEXT_MESSAGES);

						let title: string | null = null;
						for (let attempt = 0; attempt <= MAX_RETRIES; attempt++) {
							const controller = new AbortController();
							const timer = setTimeout(() => controller.abort(), TITLE_TIMEOUT_MS);
							try {
								title = await generateTitle(ctx, excerpt, controller.signal);
							} finally {
								clearTimeout(timer);
							}
							if (title) break;
							if (attempt < MAX_RETRIES) await sleep(RETRY_DELAY_MS);
						}

						if (!title) {
							errors.push(
								`${basename(session.path)}: failed after ${MAX_RETRIES + 1} attempts`,
							);
							continue;
						}

						if (!manager.getSessionName()) {
							manager.appendSessionInfo(title);
							named++;
						}
					} catch (error) {
						errors.push(
							`${basename(session.path)}: ${
								error instanceof Error ? error.message : String(error)
							}`,
						);
					}
				}
			}

			await Promise.all(
				Array.from(
					{ length: Math.min(CONCURRENCY, unnamed.length) },
					() => worker(),
				),
			);

			let message = `Named ${named} session(s)`;
			if (errors.length > 0) {
				message += `, failed ${errors.length} (still unnamed, rerun to retry)`;
			}
			ctx.ui.notify(message, "info");

			for (const error of errors.slice(0, 3)) {
				ctx.ui.notify(`name-all-sessions: ${error}`, "error");
			}
		},
	});
}
