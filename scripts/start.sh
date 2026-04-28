#!/usr/bin/env bash
set -euo pipefail

REPO_DIR="${REPO_DIR:-/home/vvasylkovskyi/my-claude-code/iac-toolbox-cli}"
FEATURE_DOCS_DIR="${FEATURE_DOCS_DIR:-/home/vvasylkovskyi/my-claude-code/context/feature-docs}"

# ── Bootstrap: run init skill if CLAUDE.md is missing ────────────────────────
if [[ ! -f "$REPO_DIR/CLAUDE.md" ]]; then
  echo "[bootstrap] CLAUDE.md not found — running init skill..."
  cd "$REPO_DIR"
  claude --dangerously-skip-permissions -p "/init Bootstrap this repository"
  echo "[bootstrap] Init complete."
fi

# ── Watcher loop ──────────────────────────────────────────────────────────────
echo "[pipeline] Watching $FEATURE_DOCS_DIR for new feature docs..."
cd "$REPO_DIR"

inotifywait -m "$FEATURE_DOCS_DIR" -e create | while read -r path _event file; do
  echo "[pipeline] Detected: $file — starting pipeline..."
  claude --dangerously-skip-permissions -p \
    "/implementation-orchestrator Process this feature doc: @${path}${file}"
  echo "[pipeline] Done: $file"
done
