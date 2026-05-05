#!/usr/bin/env bash

set -euo pipefail

BASE_DIR=$(realpath "$(dirname "${BASH_SOURCE[0]}")/../../")
source "$BASE_DIR/scripts/installer/helper.sh"

init_runtime_context

print_info "\nStarting utilities and UI setup..."

install_pacman_packages \
    brightnessctl \
    cliphist \
    libnotify \
    pamixer \
    pavucontrol \
    playerctl \
    swaync \
    thunar \
    waybar \
    wl-clipboard

install_yay_packages \
    grimblast-git \
    hyprpicker \
    jome \
    kooha \
    swww \
    tofi \
    wlogout

install_config_dir "$BASE_DIR/configs/waybar" "waybar"
install_config_dir "$BASE_DIR/configs/tofi" "tofi"
install_config_dir "$BASE_DIR/configs/wlogout" "wlogout"
install_config_dir "$BASE_DIR/configs/swaync" "swaync"
install_path "$BASE_DIR/assets/backgrounds" "$TARGET_HOME/.config/assets/backgrounds"
install_path "$BASE_DIR/assets/wlogout/assets" "$TARGET_HOME/.config/wlogout/assets"

chmod +x "$TARGET_HOME/.config/waybar/scripts/gpu.sh"
chmod +x "$TARGET_HOME/.config/waybar/scripts/storage.sh"
chown "$INSTALL_USER:$INSTALL_USER" "$TARGET_HOME/.config/waybar/scripts/gpu.sh" "$TARGET_HOME/.config/waybar/scripts/storage.sh"
