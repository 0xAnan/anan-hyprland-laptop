#!/usr/bin/env bash

set -euo pipefail

BASE_DIR=$(realpath "$(dirname "${BASH_SOURCE[0]}")/../../")
source "$BASE_DIR/scripts/installer/helper.sh"

init_runtime_context

print_info "\nStarting tmux/byobu setup..."

install_pacman_packages \
    git \
    tmux \
    wl-clipboard \
    xclip

install_home_file "$BASE_DIR/configs/tmux/.tmux.conf" ".tmux.conf"
install_config_dir "$BASE_DIR/configs/tmux" "tmux"

if [[ -f "$TARGET_HOME/.config/tmux/vpn_ip.sh" ]]; then
    chmod +x "$TARGET_HOME/.config/tmux/vpn_ip.sh"
    chown "$INSTALL_USER:$INSTALL_USER" "$TARGET_HOME/.config/tmux/vpn_ip.sh"
fi

if [[ ! -d "$TARGET_HOME/.tmux/plugins/tpm" ]]; then
    print_info "\nInstalling TPM..."
    mkdir -p "$TARGET_HOME/.tmux/plugins"
    chown -R "$INSTALL_USER:$INSTALL_USER" "$TARGET_HOME/.tmux"
    sudo -u "$INSTALL_USER" -H git clone https://github.com/tmux-plugins/tpm "$TARGET_HOME/.tmux/plugins/tpm"
fi

print_info "\nLaunch tmux with: tmux"
print_info "Inside tmux, press prefix + I the first time to install plugins."
