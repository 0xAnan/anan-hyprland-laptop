#!/usr/bin/env bash

set -euo pipefail

BASE_DIR=$(realpath "$(dirname "${BASH_SOURCE[0]}")/../../")
source "$BASE_DIR/scripts/installer/helper.sh"

init_runtime_context

print_info "\nStarting prerequisites setup..."

if ask_confirmation "Update package database and system packages?"; then
    run_command "pacman -Syu --noconfirm" "Updating system packages"
fi

install_pacman_packages git base-devel rsync tar unzip curl

if ask_confirmation "Install yay for AUR-backed packages?"; then
    ensure_yay
fi

