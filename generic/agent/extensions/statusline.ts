import { CustomEditor } from "@earendil-works/pi-coding-agent";
import type {
	ExtensionAPI,
	ExtensionContext,
	ReadonlyFooterDataProvider,
	Theme,
} from "@earendil-works/pi-coding-agent";
import { truncateToWidth, visibleWidth } from "@earendil-works/pi-tui";

/** `(bold blue)`: the format-level style, and what starship paints `❯` with. */
const BOLD_BLUE = "\x1b[1;34m";
/** `(bold cyan)`: the directory module's own style, used for every value. */
const BOLD_CYAN = "\x1b[1;36m";
/** Resets every attribute, so one segment cannot leak into the next. */
const RESET = "\x1b[0m";
/** Dim, for the gaps between segments. */
const DIM = "\x1b[2m";
const DIM_OFF = "\x1b[22m";

/** The starship character, U+276F, followed by the space starship also draws. */
const PROMPT = `${BOLD_BLUE}\u276f ${RESET}`;
/** Columns the prompt occupies, and therefore the editor's forced left padding. */
const PROMPT_WIDTH = 2;

// Nerd Font glyphs, all present in the Maple Mono NF CN terminal font.
const ICON_DIRECTORY = "\u{f027f}";
const ICON_MODEL = "\u{f06a9}";
const ICON_PROVIDER = "\u{f048b}";
const ICON_THINKING = "\u{f09d1}";
const ICON_CONTEXT = "\u{f035b}";
const ICON_SESSION = "\u{f04fc}";

/** Gap between two `[icon value]` pairs. */
const SEGMENT_GAP = "  ";
/** Minimum gap kept between the left group and the right-aligned group. */
const GROUP_GAP = 2;

const HOME = process.env.HOME || process.env.USERPROFILE;

type Segment = {
	icon: string;
	text: string;
	/** Overrides the value's color. Defaults to bold cyan. */
	style?: (text: string) => string;
};

/**
 * What the border renders from. It lives on `globalThis` rather than in this
 * module because the prototype patches installed below outlive a module reload:
 * a re-imported copy must be able to feed the already-installed renderer, whose
 * closure still belongs to the previous copy. A module-local variable would
 * leave that closure reading a context the reload has already invalidated, and
 * the status line would render blank for the rest of the process.
 */
type StatusLineState = {
	ctx: ExtensionContext | undefined;
	footerData: ReadonlyFooterDataProvider | undefined;
};

const STATE_KEY = Symbol.for("roxy.statusline");

function statusLineState(): StatusLineState {
	const store = globalThis as unknown as Record<symbol, StatusLineState | undefined>;
	store[STATE_KEY] ??= { ctx: undefined, footerData: undefined };
	return store[STATE_KEY];
}

/** `~/projects/roxy-os`, or the absolute path when the cwd is outside home. */
function formatCwd(cwd: string): string {
	if (!HOME) return cwd;
	const home = HOME.endsWith("/") ? HOME.slice(0, -1) : HOME;
	if (cwd === home) return "~";
	return cwd.startsWith(`${home}/`) ? `~${cwd.slice(home.length)}` : cwd;
}

/** Compact token count, matching the built-in footer's rounding. */
function formatTokens(count: number): string {
	if (count < 1000) return `${count}`;
	if (count < 10000) return `${(count / 1000).toFixed(1)}k`;
	if (count < 1000000) return `${Math.round(count / 1000)}k`;
	return `${(count / 1000000).toFixed(1)}M`;
}

/** The left group: session name, context usage, thinking level. */
function collectLeftSegments(ctx: ExtensionContext, theme: Theme): Segment[] {
	const segments: Segment[] = [];

	const name = ctx.sessionManager.getSessionName();
	if (name) {
		segments.push({ icon: ICON_SESSION, text: name });
	}

	const usage = ctx.getContextUsage();
	if (usage) {
		const percent = usage.percent;
		const text =
			percent === null
				? `?/${formatTokens(usage.contextWindow)}`
				: `${percent.toFixed(1)}%/${formatTokens(usage.contextWindow)}`;
		const color = percent === null ? undefined : percent > 90 ? "error" : percent > 70 ? "warning" : undefined;
		segments.push({ icon: ICON_CONTEXT, text, style: color ? (value) => theme.fg(color, value) : undefined });
	}

	const thinking = ctx.thinkingLevel;
	if (thinking) {
		segments.push({ icon: ICON_THINKING, text: thinking });
	}

	return segments;
}

/** The right group: working directory, model, provider. */
function collectRightSegments(ctx: ExtensionContext): Segment[] {
	const segments: Segment[] = [{ icon: ICON_DIRECTORY, text: formatCwd(ctx.cwd) }];

	const model = ctx.model;
	if (model) {
		segments.push({ icon: ICON_MODEL, text: model.id });
		segments.push({ icon: ICON_PROVIDER, text: model.provider });
	}

	return segments;
}

function joinSegments(segments: Segment[]): string {
	const parts = segments.map(({ icon, text, style }) => {
		const value = style ? style(text) : `${BOLD_CYAN}${text}`;
		// Mirrors `[  $directory](bold blue)`: the icon keeps the format-level
		// bold blue, the value keeps the module's own bold cyan.
		return `${BOLD_BLUE}${icon} ${value}${RESET}`;
	});
	return parts.join(`${DIM}${SEGMENT_GAP}${DIM_OFF}`);
}

/** Collapse a status text onto one line, as the built-in footer does. */
function sanitizeStatus(text: string): string {
	return text.replace(/[\r\n\t]/g, " ").replace(/ +/g, " ").trim();
}

/**
 * Statuses other extensions publish through `ctx.ui.setStatus()`, ordered by
 * their keys. The footer data provider is the only way to read them, so this is
 * empty until the footer factory has run.
 */
function collectStatuses(state: StatusLineState): string[] {
	const statuses = state.footerData?.getExtensionStatuses();
	if (!statuses || statuses.size === 0) return [];
	return Array.from(statuses.entries())
		.sort(([a], [b]) => a.localeCompare(b))
		.map(([, text]) => sanitizeStatus(text))
		.filter((text) => text.length > 0);
}

/**
 * Lay the status row out: the left group flush left, the right group flush
 * right, padded to exactly `width` columns.
 */
function renderSegments(left: Segment[], right: Segment[], width: number): string {
	const leftText = joinSegments(left);
	const leftWidth = visibleWidth(leftText);

	// Keep as much of the right group as fits beside the left group, dropping its
	// rightmost segments first so the leading, highest-priority fields survive a
	// narrow row.
	let rightText = "";
	for (let keep = right.length; keep > 0; keep--) {
		const candidate = joinSegments(right.slice(0, keep));
		if (leftWidth + GROUP_GAP + visibleWidth(candidate) <= width) {
			rightText = candidate;
			break;
		}
	}

	if (rightText === "") {
		// Nothing fits beside the left group, so it takes the whole row.
		return truncateToWidth(leftText, width, "", true);
	}

	const gap = " ".repeat(width - leftWidth - visibleWidth(rightText));
	return `${leftText}${gap}${rightText}`;
}

/** The status line, or blank padding while no session context is available. */
function renderStatusLine(width: number): string {
	if (width <= 0) return "";
	const ctx = statusLineState().ctx;
	if (!ctx) return " ".repeat(width);
	try {
		return renderSegments(collectLeftSegments(ctx, ctx.ui.theme), collectRightSegments(ctx), width);
	} catch {
		// ctx is stale between session replacement and the next session_start.
		return " ".repeat(width);
	}
}

/**
 * The row below the input: the statuses other extensions publish through
 * `ctx.ui.setStatus()`, or blank padding while there are none. pi-vim appends
 * its mode label to this row's right end afterwards, truncating the row as
 * needed to make room.
 */
function renderStatusesLine(width: number): string {
	if (width <= 0) return "";
	// Statuses are rendered as-is, so one carrying its own color keeps it.
	const statuses = collectStatuses(statusLineState()).join(" ");
	if (statuses === "") return " ".repeat(width);
	return truncateToWidth(`${RESET}${statuses}${RESET}`, width, "", true);
}

type EditorInstance = {
	render(width: number): string[];
	getPaddingX(): number;
	setPaddingX(padding: number): void;
	embedWorkingStatus?: boolean;
	/** Set when this editor's border row must stay the host's. See `install`. */
	roxyHostBorder?: boolean;
};

type EditorPrototype = EditorInstance & {
	renderBottomBorder(width: number, hiddenLineCount: number): string;
	__roxyRenderPatched?: boolean;
};

type BorderHost = {
	__roxyBordersPatched?: boolean;
	renderTopBorder(width: number, hiddenLineCount: number): string;
	renderBottomBorder(width: number, hiddenLineCount: number): string;
};

/**
 * Install the prompt and the borderless status line on every editor, by
 * patching the prototypes shared with pi-vim's modal editor.
 */
function install(): void {
	const editor = Object.getPrototypeOf(CustomEditor.prototype) as EditorPrototype;

	if (!editor.__roxyRenderPatched) {
		const baseRender = editor.render;
		editor.render = function (this: EditorInstance, width: number): string[] {
			// Clearing `embedWorkingStatus` is what moves the working indicator into
			// the status container instead of the border row this file replaces. It
			// is a `CustomEditor` field rather than part of the editor interface, so
			// a build that rejects the write must keep the host border instead of
			// dropping the indicator along with it.
			try {
				this.embedWorkingStatus = false;
			} catch {
				// The check below sees the field still set and keeps the host border.
			}
			this.roxyHostBorder = "embedWorkingStatus" in this && this.embedWorkingStatus !== false;

			// The prompt lives in the left padding, so the padding must exist and
			// be wide enough to hold it. A wider configured padding is kept,
			// because the extra columns still separate the prompt from the text.
			const padding = Math.max(PROMPT_WIDTH, this.getPaddingX());
			this.setPaddingX(padding);

			const lines = baseRender.call(this, width);
			if (lines.length < 2) return lines;

			const row = lines[1]!;
			if (!row.startsWith(" ".repeat(padding))) return lines;

			lines[1] = `${PROMPT}${row.slice(PROMPT_WIDTH)}`;
			return lines;
		};
		editor.__roxyRenderPatched = true;
	}

	// Patched on `CustomEditor` rather than on the base `Editor` so that the
	// base's own working-status embedding, which would wrap this row, is
	// bypassed.
	const host = CustomEditor.prototype as unknown as BorderHost;
	if (host.__roxyBordersPatched) return;

	const baseHostTopBorder = host.renderTopBorder;
	host.renderTopBorder = function (this: EditorInstance, width: number, hiddenLineCount: number): string {
		// An editor that still embeds its working indicator in this row keeps the
		// host border, so the indicator is never silently dropped with it.
		if (this.roxyHostBorder === true) return baseHostTopBorder.call(this, width, hiddenLineCount);
		return renderStatusLine(width);
	};

	const baseBottomBorder = editor.renderBottomBorder;
	host.renderBottomBorder = function (this: unknown, width: number, hiddenLineCount: number): string {
		// While the input is scrolled, its scroll indicator takes this row: it is
		// the more relevant information, and the host border is the only place it
		// is drawn. The rule is dropped either way, so no `─` is drawn.
		if (hiddenLineCount > 0) return baseBottomBorder.call(this, width, hiddenLineCount).replaceAll("─", " ");
		return renderStatusesLine(width);
	};

	host.__roxyBordersPatched = true;
}

export default function (pi: ExtensionAPI) {
	pi.on("session_start", (_event, ctx) => {
		if (!ctx.hasUI) return;

		statusLineState().ctx = ctx;
		install();

		// The top border carries the status line now, so the footer itself stays
		// empty — that removes the built-in pwd, branch, token, cost, and context
		// rows. Its data provider is still captured, because it is the only way to
		// read the statuses other extensions publish through `ctx.ui.setStatus()`.
		ctx.ui.setFooter((_tui, _theme, footerData) => {
			statusLineState().footerData = footerData;
			return { invalidate() {}, render: () => [] };
		});
	});
}
