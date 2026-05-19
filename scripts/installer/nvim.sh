#!/usr/bin/env bash

set -euo pipefail

BASE_DIR=$(realpath "$(dirname "${BASH_SOURCE[0]}")/../../")
source "$BASE_DIR/scripts/installer/helper.sh"

init_runtime_context

print_info "\nStarting Neovim setup..."

install_pacman_packages \
    fd \
    git \
    neovim \
    ripgrep \
    tree-sitter-cli \
    wl-clipboard \
    xclip

if ask_confirmation "Install optional Neovim helper tools (stylua, lua-language-server)?"; then
    install_pacman_packages stylua lua-language-server
fi

install_config_dir "$BASE_DIR/configs/nvim" "nvim"

print_info "\nFirst launch will bootstrap lazy.nvim, NvChad, and the plugin set."
print_info "Open Neovim with: nvim"

