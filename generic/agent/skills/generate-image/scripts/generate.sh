#!/usr/bin/env bash
# Generate an image via an OpenAI-compatible API.
#
# Usage:
#   ./generate.sh "<prompt>" <output.png> [--size 1024x1024]
#
# Env vars:
#   IMG_API_URL   API base URL, e.g. https://api.siliconflow.cn/v1
#   IMG_API_KEY   API key
#   IMG_MODEL     model id, e.g. black-forest-labs/FLUX.1-schnell
set -euo pipefail

SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"

usage() {
  sed -n '2,9p' "$SCRIPT_DIR/generate.sh" | sed 's/^# \{0,1\}//'
  exit 1
}

main() {
  : "${IMG_API_URL:?}" "${IMG_API_KEY:?}" "${IMG_MODEL:?}"

  if [ "$#" -lt 2 ]; then
    usage
  fi

  local prompt="$1"
  local out="$2"
  local size="${3:-1024x1024}"

  if [ -z "$prompt" ]; then
    echo "[generate-image] prompt must not be empty" >&2
    exit 1
  fi

  local json
  json=$(jq -n \
    --arg p "$prompt" \
    --arg m "$IMG_MODEL" \
    --arg s "$size" \
    '{model: $m, prompt: $p, size: $s, n: 1, response_format: "b64_json"}')

  echo "[generate-image] calling $IMG_API_URL/images/generations ..." >&2

  local resp
  resp=$(curl -sS -X POST "$IMG_API_URL/images/generations" \
    -H "Authorization: Bearer $IMG_API_KEY" \
    -H "Content-Type: application/json" \
    -d "$json") || {
    echo "[generate-image] curl failed: $?" >&2
    exit 1
  }

  # Check for API error
  if echo "$resp" | jq -e '.error?' > /dev/null 2>&1; then
    echo "[generate-image] API error: $(echo "$resp" | jq -r '.error.message // .error')" >&2
    exit 1
  fi

  # Decode base64 image
  echo "$resp" | jq -r '.data[0].b64_json' | base64 -d > "$out"
  echo "[generate-image] wrote $out" >&2
}

main "$@"
