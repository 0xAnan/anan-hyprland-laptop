#!/usr/bin/env bash

set -euo pipefail

BASE_DIR=$(realpath "$(dirname "${BASH_SOURCE[0]}")/../../")
source "$BASE_DIR/scripts/installer/helper.sh"

init_runtime_context

print_info "\nStarting Hyprland core setup..."

install_pacman_packages \
    hyprland \
    hyprlock \
    hypridle \
    kitty \
    polkit-kde-agent \
    qt5-wayland \
    qt6-wayland \
    xdg-desktop-portal-gtk \
    xdg-desktop-portal-hyprland

install_config_dir "$BASE_DIR/configs/hypr" "hypr"
install_config_dir "$BASE_DIR/configs/kitty" "kitty"

