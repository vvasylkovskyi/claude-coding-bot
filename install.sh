#!/usr/bin/env bash
set -euo pipefail

REPO_NAME="iac-toolbox-cli"
REPO_URL="https://github.com/vvasylkovskyi/${REPO_NAME}.git"
INSTALL_DIR="${INSTALL_DIR:-$HOME/git/${REPO_NAME}}"

# ── Check dependencies ────────────────────────────────────────────────────────
for cmd in git ansible-playbook; do
  if ! command -v "$cmd" &>/dev/null; then
    echo "Error: '$cmd' not found."
    [[ "$cmd" == "ansible-playbook" ]] && echo "  Install with: pip install ansible"
    exit 1
  fi
done

# ── Clone or update repo ──────────────────────────────────────────────────────
if [[ -d "$INSTALL_DIR/.git" ]]; then
  echo "Repo already exists at $INSTALL_DIR — pulling latest..."
  git -C "$INSTALL_DIR" pull --ff-only
else
  echo "Cloning into $INSTALL_DIR..."
  git clone "$REPO_URL" "$INSTALL_DIR"
fi

# ── Hand off to deploy script ─────────────────────────────────────────────────
echo ""
exec bash "$INSTALL_DIR/scripts/deploy.sh"