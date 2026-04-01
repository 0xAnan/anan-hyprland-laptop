#!/usr/bin/env bash

set -euo pipefail

RED='\033[0;31m'
GREEN='\033[0;32m'
YELLOW='\033[0;33m'
BLUE='\033[0;34m'
BOLD='\033[1m'
NC='\033[0m'

BASE_DIR=$(realpath "$(dirname "${BASH_SOURCE[0]}")/../../")
LOG_FILE="$BASE_DIR/scripts/installer/install.log"
REPO_NAME="anan-hyprland-laptop"

print_error() {
    echo -e "${RED}$1${NC}"
}

print_success() {
    echo -e "${GREEN}$1${NC}"
}

print_warning() {
    echo -e "${YELLOW}$1${NC}"
}

print_info() {
    echo -e "${BLUE}$1${NC}"
}

print_bold_blue() {
    echo -e "${BLUE}${BOLD}$1${NC}"
}

log_message() {
    mkdir -p "$(dirname "$LOG_FILE")"
    echo "$(date '+%F %T') $1" >> "$LOG_FILE"
}

trap_message() {
    print_error "\nInstaller interrupted."
    log_message "Installer interrupted"
    exit 1
}

ask_confirmation() {
    local prompt="$1"

    while true; do
        read -r -p "$(printf "${YELLOW}%s (y/n): ${NC}" "$prompt")" REPLY
        case "$REPLY" in
            [Yy]) return 0 ;;
            [Nn]) return 1 ;;
            *) print_error "Please answer y or n." ;;
        esac
    done
}

check_root() {
    if [[ $EUID -ne 0 ]]; then
        print_error "Please run this installer with sudo."
        exit 1
    fi
}

init_runtime_context() {
    check_root

    if [[ -z "${INSTALL_USER:-}" ]]; then
        INSTALL_USER="${SUDO_USER:-$(logname)}"
        export INSTALL_USER
    fi

    if [[ -z "${TARGET_HOME:-}" ]]; then
        TARGET_HOME="$(getent passwd "$INSTALL_USER" | cut -d: -f6)"
        export TARGET_HOME
    fi

    if [[ -z "${BACKUP_DIR:-}" ]]; then
        BACKUP_DIR="$TARGET_HOME/.config-backups/${REPO_NAME}-$(date '+%F-%H%M%S')"
        export BACKUP_DIR
    fi

    mkdir -p "$BACKUP_DIR"
    log_message "Runtime context initialized for user $INSTALL_USER"
}

check_os() {
    if [[ -f /etc/os-release ]]; then
        . /etc/os-release
        if [[ "${ID:-}" != "arch" ]]; then
            print_warning "This installer is designed for Arch Linux. Detected: ${PRETTY_NAME:-unknown}"
            ask_confirmation "Continue anyway?" || exit 1
        fi
    else
        print_warning "Could not detect the OS from /etc/os-release."
        ask_confirmation "Continue anyway?" || exit 1
    fi
}

run_script() {
    local script="$BASE_DIR/scripts/installer/$1"
    local description="$2"

    if ask_confirmation "Run $description"; then
        log_message "Starting $description"
        bash "$script"
        print_success "$description completed."
        log_message "Completed $description"
    else
        print_warning "Skipped $description"
        log_message "Skipped $description"
    fi
}

run_command() {
    local cmd="$1"
    local description="$2"

    print_info "\n$description"
    log_message "$description :: $cmd"
    bash -lc "$cmd"
}

ensure_yay() {
    if command -v yay >/dev/null 2>&1; then
        return 0
    fi

    print_info "\nInstalling yay..."
    pacman -S --needed --noconfirm git base-devel

    local build_dir
    build_dir="$(mktemp -d)"
    chown "$INSTALL_USER:$INSTALL_USER" "$build_dir"

    sudo -u "$INSTALL_USER" -H bash -lc "git clone https://aur.archlinux.org/yay.git '$build_dir/yay' && cd '$build_dir/yay' && makepkg -si --noconfirm"
}

install_pacman_packages() {
    if [[ $# -eq 0 ]]; then
        return 0
    fi

    print_info "\nInstalling pacman packages: $*"
    log_message "pacman install :: $*"
    pacman -S --needed --noconfirm "$@"
}

install_yay_packages() {
    if [[ $# -eq 0 ]]; then
        return 0
    fi

    ensure_yay
    print_info "\nInstalling yay packages: $*"
    log_message "yay install :: $*"
    sudo -u "$INSTALL_USER" -H yay -S --needed --noconfirm "$@"
}

backup_path() {
    local target="$1"

    if [[ ! -e "$target" && ! -L "$target" ]]; then
        return 0
    fi

    local rel_path="${target#$TARGET_HOME/}"
    if [[ "$rel_path" == "$target" ]]; then
        rel_path="$(basename "$target")"
    fi

    local backup_target="$BACKUP_DIR/$rel_path"
    mkdir -p "$(dirname "$backup_target")"
    mv "$target" "$backup_target"

    print_warning "Backed up $target -> $backup_target"
    log_message "Backed up $target -> $backup_target"
}

install_path() {
    local src="$1"
    local target="$2"

    backup_path "$target"
    mkdir -p "$(dirname "$target")"

    if [[ -d "$src" ]]; then
        mkdir -p "$target"
        cp -a "$src"/. "$target"/
        chown -R "$INSTALL_USER:$INSTALL_USER" "$target"
    else
        cp -a "$src" "$target"
        chown "$INSTALL_USER:$INSTALL_USER" "$target"
    fi

    print_success "Installed $(basename "$src") -> $target"
    log_message "Installed $src -> $target"
}

install_config_dir() {
    local src="$1"
    local rel_target="$2"
    install_path "$src" "$TARGET_HOME/.config/$rel_target"
}

install_home_file() {
    local src="$1"
    local rel_target="$2"
    install_path "$src" "$TARGET_HOME/$rel_target"
}

extract_archive() {
    local archive="$1"
    local destination="$2"

    print_info "\nExtracting $(basename "$archive") to $destination"
    mkdir -p "$destination"
    tar -xJf "$archive" -C "$destination"
    log_message "Extracted $archive to $destination"
}
