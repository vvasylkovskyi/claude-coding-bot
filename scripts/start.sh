#!/usr/bin/env bash
set -euo pipefail

REPO_DIR="${REPO_DIR:-/home/vvasylkovskyi/my-claude-code/iac-toolbox-cli}"
FEATURE_DOCS_DIR="${FEATURE_DOCS_DIR:-/home/vvasylkovskyi/my-claude-code/context/feature-docs}"

CLAUDE_BIN=$(find /usr/local/bin "$HOME/.local/bin" "$HOME/.npm-global/bin" -name claude 2>/dev/null | head -1)
if [[ -z "$CLAUDE_BIN" ]]; then
  echo "Error: claude binary not found in standard locations" >&2
  exit 1
fi

# ── Bootstrap: run init skill if CLAUDE.md is missing ────────────────────────
if [[ ! -f "$REPO_DIR/CLAUDE.md" ]]; then
  echo "[bootstrap] CLAUDE.md not found — running init skill..."
  cd "$REPO_DIR"
  "$CLAUDE_BIN" --dangerously-skip-permissions -p "/init Bootstrap this repository"
  echo "[bootstrap] Init complete."
fi

# ── Watcher loop ──────────────────────────────────────────────────────────────
echo "[pipeline] Watching $FEATURE_DOCS_DIR for new feature docs..."
cd "$REPO_DIR"

inotifywait -m "$FEATURE_DOCS_DIR" -e create | while read -r path _event file; do
  echo "[pipeline] Detected: $file — starting pipeline..."
  "$CLAUDE_BIN" --dangerously-skip-permissions -p \
    "/implementation-orchestrator Process this feature doc: @${path}${file}"
  echo "[pipeline] Done: $file"
done
