#!/usr/bin/env bash

set -euo pipefail

BASE_DIR=$(realpath "$(dirname "${BASH_SOURCE[0]}")/../../")
source "$BASE_DIR/scripts/installer/helper.sh"

init_runtime_context

install_theme_symlink() {
    local src="$1"
    local target="$2"

    backup_path "$target"
    mkdir -p "$(dirname "$target")"
    ln -s "$src" "$target"
    chown -h "$INSTALL_USER:$INSTALL_USER" "$target"

    print_success "Installed symlink $target -> $src"
    log_message "Installed symlink $target -> $src"
}

print_info "\nStarting theme and font setup..."

install_pacman_packages \
    hyprcursor \
    inter-font \
    kvantum \
    nwg-look \
    qt5ct \
    qt6ct \
    ttf-fira-sans \
    ttf-jetbrains-mono-nerd \
    ttf-nerd-fonts-symbols \
    ttf-nerd-fonts-symbols-mono \
    ttf-ubuntu-nerd

install_yay_packages \
    kvantum-theme-catppuccin-git \
    sweet-cursors-hyprcursor-git

extract_archive "$BASE_DIR/assets/themes/Catppuccin-Mocha.tar.xz" "/usr/share/themes"
extract_archive "$BASE_DIR/assets/icons/Tela-circle-dracula.tar.xz" "/usr/share/icons"
extract_archive "$BASE_DIR/assets/icons/Sweet-cursors.tar.xz" "/usr/share/icons"

install_config_dir "$BASE_DIR/configs/gtk-3.0" "gtk-3.0"
install_config_dir "$BASE_DIR/configs/gtk-4.0" "gtk-4.0"
install_config_dir "$BASE_DIR/configs/nwg-look" "nwg-look"
install_config_dir "$BASE_DIR/configs/xsettingsd" "xsettingsd"
install_home_file "$BASE_DIR/configs/home/.gtkrc-2.0" ".gtkrc-2.0"
install_home_file "$BASE_DIR/configs/home/.local/share/icons/default/index.theme" ".local/share/icons/default/index.theme"

install_theme_symlink "/usr/share/themes/Catppuccin-Mocha/gtk-4.0/assets" "$TARGET_HOME/.config/gtk-4.0/assets"
install_theme_symlink "/usr/share/themes/Catppuccin-Mocha/gtk-4.0/gtk.css" "$TARGET_HOME/.config/gtk-4.0/gtk.css"
install_theme_symlink "/usr/share/themes/Catppuccin-Mocha/gtk-4.0/gtk-dark.css" "$TARGET_HOME/.config/gtk-4.0/gtk-dark.css"

print_info "\nGTK theme, icon theme, cursor theme, and fonts are now installed."
print_info "If you want to adjust them manually later, use nwg-look, qt5ct, qt6ct, or Kvantum Manager."
