#!/usr/bin/env bash

set -euo pipefail

BASE_DIR=$(realpath "$(dirname "${BASH_SOURCE[0]}")/../../")
source "$BASE_DIR/scripts/installer/helper.sh"

init_runtime_context

print_info "\nStarting optional extras..."
print_warning "These extras mirror your current desktop workflow. They are not required for the base laptop setup."

if ask_confirmation "Install Firefox and Chromium?"; then
    install_pacman_packages firefox chromium
fi

if ask_confirmation "Install Brave?"; then
    install_yay_packages brave-bin
fi

if ask_confirmation "Install personal daily apps (Obsidian, Discord, Spotify, WhatsDesk, VS Code)?"; then
    install_yay_packages obsidian discord spotify whatsdesk-bin visual-studio-code-bin
fi

if ask_confirmation "Install OpenRGB?"; then
    install_yay_packages openrgb
fi

if ask_confirmation "Activate the personal Hypr autostart example?"; then
    install_path "$BASE_DIR/configs/hypr/autostart-personal.conf.example" "$TARGET_HOME/.config/hypr/autostart-personal.conf"
fi

if ask_confirmation "Activate the NVIDIA environment example?"; then
    install_path "$BASE_DIR/configs/hypr/env-nvidia.conf.example" "$TARGET_HOME/.config/hypr/env-nvidia.conf"
fi

if ask_confirmation "Install the legacy Dunst config too? This is not recommended if you plan to keep SwayNC running."; then
    install_pacman_packages dunst
    install_config_dir "$BASE_DIR/configs/dunst" "dunst"
fi

