# 🌌 J0X's CachyOS Advanced Setup 🌌

Welcome to my personal, highly customized, and heavily optimized Linux setup. This repository contains dotfiles and configurations for a state-of-the-art **CachyOS** environment, featuring the **Niri** compositor, **Nocria** shell, a complete suite of **BlackArch** penetration testing tools, and a stunning custom **Limine** bootloader theme.

## ✨ Features

- ⚡ **Base OS**: CachyOS (Arch Linux optimized for performance)
- 🪟 **Compositor**: Niri (Scrollable-tiling Wayland compositor)
- 🐚 **Shell**: Nocria (Custom, highly aesthetic shell setup)
- 🛡️ **Pentesting Arsenal**: BlackArch tools integrated seamlessly
- 🚀 **Bootloader**: Custom Limine bootloader with a dark, premium aesthetic
- 🎨 **Aesthetics**: Glassmorphism, dynamic animations, and curated dark modes

## ⌨️ Keyboard Shortcuts

This setup uses a combination of "Windows-familiar" shortcuts and intelligent tiling controls for the Niri compositor:

*Note: `Mod` refers to the Super/Windows key.*

### System & Applications

| Shortcut | Action |
| :--- | :--- |
| **`Alt+Space`** | Open App Launcher (Noctalia) |
| **`Mod+E`** | Open File Manager (Nautilus) |
| **`Mod+T`** | Open Terminal (Alacritty) |
| **`Mod+B`** | Open Browser (Firefox) |
| **`Ctrl+Shift+Escape`** | Task Manager (btop) |
| **`Mod+P`** / **`XF86Display`** | Displays (nwg-displays) |
| **`Mod+L`** | Lock Screen (swaylock) |
| **`Mod+Shift+Q`** | Session Menu |
| **`Mod+F1`** / **`Mod+Shift+Escape`** | Show shortcuts help |

### Window Management

| Shortcut | Action |
| :--- | :--- |
| **`Alt+F4`** / **`Mod+Q`** | Close active window |
| **`F11`** / **`Mod+Shift+F`** | Fullscreen window |
| **`Mod+D`** | Toggle Overview (Show Desktop) |
| **`Alt+Tab`** | Focus next column (right) |
| **`Alt+Shift+Tab`** | Focus previous column (left) |
| **`Mod+T`** | Toggle window floating |
| **`Mod+W`** | Toggle column tabbed display |

### Tiling & Navigation

| Shortcut | Action |
| :--- | :--- |
| **`Mod+Left/Right/H/L`** | Focus column left/right |
| **`Mod+Up`** | Maximize column |
| **`Mod+Down/J/K`** | Focus window down/up |
| **`Mod+Ctrl+Left/Right/H/L`** | Move column left/right |
| **`Ctrl+Alt+Left/Right`** | Move column left/right |
| **`Mod+Ctrl+Up/Down/J/K`** | Move window up/down |
| **`Mod+Home/End`** | Focus first/last column |
| **`Mod+Ctrl+Home/End`** | Move column to first/last position |

### Workspaces & Monitors

| Shortcut | Action |
| :--- | :--- |
| **`Mod+1-9`** | Focus workspace 1-9 |
| **`Mod+Ctrl+1-9`** | Move column to workspace 1-9 |
| **`Mod+Tab`** | Focus previous workspace |
| **`Mod+WheelScroll`** | Focus/Move across workspaces and columns |
| **`Mod+Shift+Left/Right/Up/Down`** | Focus monitor |
| **`Mod+Shift+Ctrl+Left/Right/Up/Down`** | Move column to monitor |

### Sizing & Layout

| Shortcut | Action |
| :--- | :--- |
| **`Mod+Ctrl+F`** | Expand column to available width |
| **`Mod+C`** / **`Mod+Ctrl+C`** | Center column / Center visible columns |
| **`Mod+Minus/Equal`** | Decrease/Increase column width |
| **`Mod+Shift+Minus/Equal`** | Decrease/Increase window height |

### Media, Brightness & System

| Shortcut | Action |
| :--- | :--- |
| **`Print`** / **`Ctrl+Shift+1`** | Screenshot (Area) |
| **`Ctrl+Print`** / **`Ctrl+Shift+2`** | Screenshot (Screen) |
| **`Alt+Print`** / **`Ctrl+Shift+3`** | Screenshot (Window) |
| **`Media Keys`** | Volume Up/Down/Mute, Play/Pause, Next/Prev |
| **`Brightness Keys`** | Screen Brightness Up/Down |
| **`Mod+Escape`** | Toggle keyboard shortcuts inhibit (Escape hatch) |
| **`Ctrl+Alt+Delete`** | Quit Niri |
| **`Mod+Shift+P`** | Power off monitors |
## 📂 Repository Structure

- `niri/`: Configuration for the Niri compositor (`~/.config/niri/`)
- `nocria/`: Shell configuration and styling (`~/.config/nocria/`)
- `limine/`: Custom Limine bootloader themes and configuration (`/boot/efi/EFI/limine/`)
- `scripts/`: Useful automation and setup scripts

## 🚀 Installation

*Warning: This setup is tailored for my specific hardware and workflow. Review the scripts before running them on your machine.*

```bash
# 1. Clone the repository with submodules
git clone --recurse-submodules https://github.com/j0x/My-Arch-Setup-Configs.git ~/.dotfiles
cd ~/.dotfiles

# (If you already cloned it without submodules, run this instead:)
# git submodule update --init --recursive

# 2. Make the installer executable
chmod +x install.sh

# 3. Run the installer to symlink configs
./install.sh
```

## 🤖 Agent Instructions (For AI Assistants)
When adding new files or configurations, AI agents must adhere to the rules in `.cursorrules`, which include:
- Documenting the exact target paths for deployment in the file header.
- Explaining dependencies (especially BlackArch tools).
- Updating `install.sh` to automatically symlink the new config.
