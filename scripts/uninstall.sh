#!/usr/bin/env bash
set -euo pipefail

SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
REPO_DIR="$(dirname "$SCRIPT_DIR")"

PI_HOST="${PI_HOST:-raspberrypi.local}"
sed -i "s/raspberrypi.local/$PI_HOST/" "$REPO_DIR/inventory.ini"

echo "Uninstalling from $PI_HOST..."
exec ansible-playbook \
  -i "$REPO_DIR/inventory.ini" \
  "$REPO_DIR/playbook-uninstall.yml"
