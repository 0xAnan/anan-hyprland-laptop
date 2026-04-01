# Anan Hyprland Laptop

This repo packages your current Hyprland setup into a GitHub-ready, Arch-focused installer modeled after `simple-hyprland`, but adapted for a single-monitor laptop instead of your current dual-monitor desktop.

## Quick Install

```bash
git clone <your-repo-url> ~/anan-hyprland-laptop
cd ~/anan-hyprland-laptop/scripts/installer
sudo bash install.sh
```

## What This Repo Installs By Default

- Hyprland, Hyprlock, Hypridle
- Waybar, Tofi, SwayNC, Wlogout
- Kitty
- GTK theme settings
- Wallpapers and Wlogout assets
- Catppuccin Mocha, Tela Circle Dracula, Sweet cursors
- Fonts needed by the desktop theme

## Optional Extras

- Your personal app autostarts
- NVIDIA-specific environment overrides
- Legacy Dunst config
- Personal apps like Brave, Discord, Obsidian, Spotify, WhatsDesk, VS Code, OpenRGB

## Laptop Adaptation

This repo intentionally changes a few things from the live desktop config:

- Collapses the layout to one generic monitor
- Removes monitor-name-specific Waybar outputs
- Removes monitor-bound workspace routing
- Keeps NVIDIA env in an example file instead of enabling it by default
- Keeps personal autostarts in an example file instead of forcing them on fresh installs
- Replaces hardcoded Wlogout asset paths with portable relative paths

## Repo Layout

```text
assets/
configs/
docs/
scripts/installer/
```

## Included Configs

See [docs/included-configs.md](docs/included-configs.md) for the exact list of files included, optional pieces, and intentional omissions.
