---
name: generate-image
description: Generate images by calling an OpenAI-compatible image API (/v1/images/generations). Use when the user asks to create, generate, or draw an image, or when a workflow needs an AI-generated image asset.
---

# Generate Image

## Setup

Requires env vars (set via the nix dev shell or direnv):

- `IMG_API_URL` — API base, e.g. `https://api.siliconflow.cn/v1`
- `IMG_API_KEY` — API key
- `IMG_MODEL` — model id, e.g. `black-forest-labs/FLUX.1-schnell`

The script requires `jq` and `curl` (both available in the nix dev shell).

## Usage

```bash
./scripts/generate.sh "<prompt>" <output.png> [--size 1024x1024]
```

## Prompting

Write prompts in terms of concrete, observable visual elements. A useful order is:

```text
[subject] + [action or state] + [environment] + [composition and viewpoint] + [lighting] + [style] + [color] + [materials and details] + [output requirements]
```

For example:

```text
A lone astronaut repairing a small rover on the surface of Mars, wide cinematic composition, astronaut positioned on the right third, low camera angle, Earth visible near the horizon, harsh sunset rim light, realistic sci-fi concept art, muted red and charcoal palette, detailed dust and metallic textures, high contrast, 16:9 landscape
```

Guidelines:

- Put the most important subject first. Use concrete nouns such as `red wool coat` instead of abstract descriptions such as `beautiful clothing`.
- Describe things the model can depict: `three-quarter view`, `top-down view`, `soft window light`, and `shallow depth of field` are more useful than vague aesthetic language.
- Specify counts, positions, and relationships when they matter: `two figures, one in the foreground and one in the background`.
- Describe composition explicitly with terms such as `centered portrait`, `symmetrical composition`, `subject on the left third`, or `wide establishing shot`.
- Keep the style direction focused. One or two compatible styles are usually easier to control than a long list of conflicting styles.
- Call out text, logos, hands, complex mechanical structures, and other details that need particular attention. Generate several candidates when exact rendering matters.
- Add model-specific parameters, such as aspect ratio, resolution, lens, or reference-image weight, when the model supports them.

If the model supports negative prompts, use them for unwanted visual defects:

```text
blurry, low resolution, distorted anatomy, extra fingers, duplicate objects, cropped subject, unreadable text, watermark
```

Negative prompts are not supported by every model. When they are unavailable, express the desired result positively, for example `clean hands with five natural fingers` rather than only `no bad hands`.

Useful starting templates:

```text
[subject] in [environment], [action or state], [composition and viewpoint], [lighting], [visual style], [key materials and details], [color palette], [aspect ratio]
```

For common use cases:

```text
Editorial portrait of a middle-aged Japanese architect, calm expression, natural skin texture, dark navy jacket, soft side lighting, neutral studio background, 85mm lens, shallow depth of field, realistic photography
```

```text
A matte-black wireless headphone on a pale concrete pedestal, three-quarter product view, soft studio lighting, subtle shadow, clean warm-gray background, premium industrial design, sharp focus, commercial product photography, no text, 4:5
```

```text
An abandoned coastal research station built into a cliff, viewed from across the bay, storm clouds, small figures for scale, functional architecture, weathered concrete and rusted steel, dramatic overcast light, realistic environment concept art, wide establishing shot, 21:9
```

Start with the subject, scene, and composition, then add lighting, materials, and style in later iterations. This makes it easier to identify which part of a prompt is causing an unwanted result.

## Notes

- If the API returns an error, report it verbatim; do not retry with a different
  endpoint or silently fall back.
