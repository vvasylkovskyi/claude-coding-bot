#!/usr/bin/env bash
set -euo pipefail

SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
REPO_NAME=$(grep '^service_name:' "$SCRIPT_DIR/common.yml" | awk '{print $2}')
INSTALL_DIR="${INSTALL_DIR:-$HOME/git/${REPO_NAME}}"

# ── Check dependencies ────────────────────────────────────────────────────────
if ! command -v ansible-playbook &>/dev/null; then
  echo "Error: ansible-playbook not found. Install with: pip install ansible"
  exit 1
fi

# ── Resolve inventory ─────────────────────────────────────────────────────────
if [[ ! -d "$INSTALL_DIR/.git" ]]; then
  echo "Error: repo not found at $INSTALL_DIR. Nothing to uninstall."
  exit 1
fi

PI_HOST="${PI_HOST:-raspberrypi.local}"
sed -i "s/raspberrypi.local/$PI_HOST/" "$INSTALL_DIR/inventory.ini"

# ── Run uninstall playbook ────────────────────────────────────────────────────
echo "Uninstalling from $PI_HOST..."
exec ansible-playbook \
  -i "$INSTALL_DIR/inventory.ini" \
  "$INSTALL_DIR/playbook-uninstall.yml"
