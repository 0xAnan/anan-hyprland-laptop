# Included Configs

## Installed By Default

- `configs/hypr/hyprland.conf`
- `configs/hypr/hypridle.conf`
- `configs/hypr/hyprlock.conf`
- `configs/waybar/config.jsonc`
- `configs/waybar/style.css`
- `configs/waybar/scripts/gpu.sh`
- `configs/waybar/scripts/storage.sh`
- `configs/kitty/kitty.conf`
- `configs/kitty/theme.conf`
- `configs/tofi/configA`
- `configs/tofi/configV`
- `configs/wlogout/layout`
- `configs/wlogout/style.css`
- `configs/swaync/config.json`
- `configs/swaync/style.css`
- `configs/swaync/icons/*`
- `configs/gtk-3.0/settings.ini`
- `configs/gtk-4.0/settings.ini`
- `configs/nwg-look/config`
- `configs/xsettingsd/xsettingsd.conf`
- `configs/home/.gtkrc-2.0`
- `configs/home/.local/share/icons/default/index.theme`
- `assets/backgrounds/*`
- `assets/wlogout/assets/*`
- `assets/themes/Catppuccin-Mocha.tar.xz`
- `assets/icons/Tela-circle-dracula.tar.xz`
- `assets/icons/Sweet-cursors.tar.xz`

## Included But Optional

- `configs/hypr/autostart-personal.conf.example`
- `configs/hypr/env-nvidia.conf.example`
- `configs/dunst/dunstrc`

## Personal Behavior Captured

- Arabic and US keyboard layout toggle on `Alt+Shift`
- Tofi launcher and clipboard picker
- Waybar modules for battery, backlight, storage, GPU, audio, notifications
- Hyprlock, Hypridle, screenshots, emoji picker, color picker, screen recording
- Workspace assignment rules for your common apps
- Catppuccin-based theme stack

## Intentional Omissions

- `~/.config/gtk-3.0/bookmarks`
  It contains machine-local file manager state.
- `~/.config/qt5ct/qt5ct.conf`
  It only stores window geometry on this machine.
- `~/.config/qt6ct/qt6ct.conf`
  It only stores window geometry on this machine.
- `~/.zshrc`
  It is not part of the Hyprland desktop setup.
- Desktop-only monitor mappings
  Removed so the repo works on a single laptop display.
- `device { name = epic-mouse-v1 }`
  Removed because it is tied to a specific external mouse.

## Laptop-Specific Changes

- `monitor = , preferred, auto, 1` is now the default monitor rule.
- Waybar is reduced to one portable bar definition.
- Backlight config no longer hardcodes `intel_backlight`.
- Personal autostarts are moved into an opt-in example file.
- NVIDIA env overrides are moved into an opt-in example file.
- Wlogout icon paths are now relative so they install cleanly on any username.
- GTK4 theme symlinks are recreated by the installer instead of being stored as absolute links in the repo.
