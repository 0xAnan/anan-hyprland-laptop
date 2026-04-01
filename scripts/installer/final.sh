#!/usr/bin/env bash

set -euo pipefail

BASE_DIR=$(realpath "$(dirname "${BASH_SOURCE[0]}")/../../")
source "$BASE_DIR/scripts/installer/helper.sh"

init_runtime_context

print_bold_blue "\nFinal Notes"
echo "  - Backup directory: $BACKUP_DIR"
echo "  - Main config: ~/.config/hypr/hyprland.conf"
echo "  - Optional personal autostarts: ~/.config/hypr/autostart-personal.conf"
echo "  - Optional NVIDIA overrides: ~/.config/hypr/env-nvidia.conf"
echo "  - Included config inventory: docs/included-configs.md"
echo
echo "Log out, choose Hyprland in your display manager, and log back in."

