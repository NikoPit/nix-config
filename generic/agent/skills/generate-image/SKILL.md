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

## Notes

- If the API returns an error, report it verbatim; do not retry with a different
  endpoint or silently fall back.
