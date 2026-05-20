#!/usr/bin/env bash

set -euo pipefail

BASE_DIR=$(realpath "$(dirname "${BASH_SOURCE[0]}")/../../")
source "$BASE_DIR/scripts/installer/helper.sh"

init_runtime_context

print_info "\nStarting shell setup..."

install_pacman_packages \
    bat \
    eza \
    fzf \
    starship \
    thefuck \
    zoxide \
    zsh \
    zsh-autosuggestions

install_config_dir "$BASE_DIR/configs/starship" "starship"
install_home_file "$BASE_DIR/configs/zsh/.zshrc" ".zshrc"

if ask_confirmation "Install the Neovim setup too?"; then
    bash "$BASE_DIR/scripts/installer/nvim.sh"
fi

if ask_confirmation "Install the tmux setup too?"; then
    bash "$BASE_DIR/scripts/installer/tmux.sh"
fi

if ask_confirmation "Set zsh as the default shell for $INSTALL_USER?"; then
    chsh -s /bin/zsh "$INSTALL_USER"
    print_success "Default shell changed to zsh for $INSTALL_USER."
fi

print_info "\nOpen a new terminal or run: exec zsh"
