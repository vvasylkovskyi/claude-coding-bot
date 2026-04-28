#!/usr/bin/env bash
set -euo pipefail

SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
REPO_DIR="$(dirname "$SCRIPT_DIR")"

# ── Prompt for token if not set ───────────────────────────────────────────────
if [[ -z "${CLAUDE_TOKEN:-}" ]]; then
  read -rsp "Claude OAuth token (from 'claude setup-token'): " CLAUDE_TOKEN
  echo
fi

# ── Optional overrides ────────────────────────────────────────────────────────
PI_HOST="${PI_HOST:-raspberrypi.local}"
FEATURE_DOCS_DIR="${FEATURE_DOCS_DIR:-}"

perl -i -pe "s/raspberrypi.local/$PI_HOST/g" "$REPO_DIR/inventory.ini"

# ── Build extra-vars ──────────────────────────────────────────────────────────
EXTRA_VARS="claude_token=$CLAUDE_TOKEN"
[[ -n "$FEATURE_DOCS_DIR" ]] && EXTRA_VARS="$EXTRA_VARS feature_docs_dir=$FEATURE_DOCS_DIR"

# ── Run playbook ──────────────────────────────────────────────────────────────
echo "Deploying to $PI_HOST..."
ansible-playbook \
  -i "$REPO_DIR/inventory.ini" \
  "$REPO_DIR/playbook.yml" \
  --extra-vars "$EXTRA_VARS" \
  "$@"

echo ""
DOCS_DIR="${FEATURE_DOCS_DIR:-~/my-claude-code/context/feature-docs}"
echo "Done! Drop a .md file into $DOCS_DIR on the Pi to trigger a PR."
