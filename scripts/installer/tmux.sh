#!/usr/bin/env bash

set -euo pipefail

BASE_DIR=$(realpath "$(dirname "${BASH_SOURCE[0]}")/../../")
source "$BASE_DIR/scripts/installer/helper.sh"

init_runtime_context

print_info "\nStarting tmux/byobu setup..."

install_pacman_packages \
    byobu \
    tmux \
    wl-clipboard \
    xclip

install_config_dir "$BASE_DIR/configs/byobu" "byobu"
install_config_dir "$BASE_DIR/configs/tmux" "tmux"

if [[ -f "$TARGET_HOME/.config/tmux/vpn_ip.sh" ]]; then
    chmod +x "$TARGET_HOME/.config/tmux/vpn_ip.sh"
    chown "$INSTALL_USER:$INSTALL_USER" "$TARGET_HOME/.config/tmux/vpn_ip.sh"
fi

print_info "\nYour tmux setup is based on byobu."
print_info "Launch it with: byobu-tmux"

