```text
╔═══════════════════════════════════════════════════════════════════╗
║                                                                   ║
║       ██╗ ██████╗ ██╗  ██╗    ██████╗  ██████╗ ████████╗███████╗  ║
║       ██║██╔═══██╗╚██╗██╔╝    ██╔══██╗██╔═══██╗╚══██╔══╝██╔════╝  ║
║       ██║██║   ██║ ╚███╔╝     ██║  ██║██║   ██║   ██║   ███████╗  ║
║  ██   ██║██║   ██║ ██╔██╗     ██║  ██║██║   ██║   ██║   ╚════██║  ║
║  ╚█████╔╝╚██████╔╝██╔╝ ██╗    ██████╔╝╚██████╔╝   ██║   ███████║  ║
║   ╚════╝  ╚═════╝ ╚═╝  ╚═╝    ╚═════╝  ╚═════╝    ╚═╝   ╚══════╝  ║
║                                                                   ║
╚═══════════════════════════════════════════════════════════════════╝
```

<p align="center">
  <b>The Ultimate Arch Linux Desktop for Windows Dual Booters</b>
  <br>
  <sub>Niri · Noctalia · Keyd · Ydotool - Production-grade Wayland dotfiles with CI/CD validation</sub>
</p>

<p align="center">
  <a href="https://github.com/John-Varghese-EH/niri-ultimate-config/actions/workflows/validate.yml">
    <img src="https://github.com/John-Varghese-EH/niri-ultimate-config/actions/workflows/validate.yml/badge.svg" alt="Validate Configs">
  </a>
  <a href="LICENSE">
    <img src="https://img.shields.io/badge/license-GPL--3.0-blue.svg" alt="License">
  </a>
  <img src="https://img.shields.io/badge/compositor-Niri-8B5CF6?logo=wayland" alt="Niri">
  <img src="https://img.shields.io/badge/platform-Arch%20Linux-1793D1?logo=archlinux&logoColor=white" alt="Arch Linux">
  <img src="https://img.shields.io/badge/session-Wayland-4B8BBE" alt="Wayland">
</p>

<p align="center">
  <a href="#-installation">Install</a> •
  <a href="KEYBINDS.md">Keybinds</a> •
  <a href="#%EF%B8%8F-the-tech-stack">Tools</a> •
  <a href="CONTRIBUTING.md">Contribute</a>
</p>

---

## What This Is

A complete, validated, and battle-tested desktop configuration that makes **Arch Linux feel like a supercharged version of Windows**. Every shortcut you already know (`Win+E`, `Alt+F4`, `Ctrl+Shift+Esc`) works out of the box - plus powerful Linux-exclusive capabilities layered on top.

This is not a rice or a theme. It is a **production-grade workflow engine** with:

-  CI/CD validated configs - every push is checked by `niri validate`, `keyd check`, and `shellcheck`
-  Interactive installer with dry-run, backup, uninstall, and dependency management
-  Custom text expansion macros configurable during install
-  Keyboard-driven mouse control via `ydotool`
-  A full virtual numpad layer on the home row

## Why This is the Best Niri Configuration

| Feature | How It Works |
|---|---|
| **Zero-Friction Windows Transition** | Native bindings for `Win+E`, `Alt+F4`, `Win+L`, `Ctrl+Shift+Esc`, `Win+V`, `Win+P`, `Alt+Tab` |
| **Kernel-Level Key Remapping** | `keyd` overloads CapsLock → Esc/Ctrl, adds navigation + numpad layers on RightAlt |
| **Keyboard Mouse Control** | `ydotool` injects cursor movement via `RightAlt+Shift+WASD` |
| **Text Expansion Macros** | Type your email/URLs/signatures instantly with `RightAlt+1/2/3` |
| **Space Cadet Shift** | Tap Left/Right Shift for `(`/`)` parentheses |
| **Wayland Macro Fix** | Built-in `macro_sequence_timeout` prevents character drops |
| **12 Extra Function Keys** | `Shift+F1-F12` maps to `F13-F24` for app-specific shortcuts |

## The Tech Stack

Every tool in this stack has a reason. Nothing is decorative - everything maps to a keybind.

| Tool | What It Does | Triggered By |
|---|---|---|
| **[Niri](https://github.com/YaLTeR/niri)** | Scrollable-tiling Wayland compositor | Core - manages all windows |
| **[Keyd](https://github.com/rvaiya/keyd)** | Kernel-level key remapping daemon | Always active - all layers |
| **[Ydotool](https://github.com/ReimuNotMoe/ydotool)** | Wayland input injection | `RightAlt+Shift+WASD/J/K` |
| **[Noctalia Shell](https://github.com/nicories/noctalia)** | Bar, launcher, session menus | `Win+R`, `Win+X`, `Win+L` |
| **[Waybar](https://github.com/Alexays/Waybar)** | Status bar with system tray | Auto-starts with Niri |
| **[Alacritty](https://github.com/alacritty/alacritty)** | GPU-accelerated terminal | `Ctrl+Alt+T`, `Win+Enter` |
| **[Btop](https://github.com/aristocratos/btop)** | Resource monitor | `Ctrl+Shift+Esc` |
| **[Fuzzel](https://codeberg.org/dnkl/fuzzel)** | Wayland dmenu replacement | Clipboard picker via `Win+V` |
| **[Cliphist](https://github.com/sentriz/cliphist)** | Clipboard history manager | `Win+V` |
| **[Wdisplays](https://github.com/artizirk/wdisplays)** | Display configurator GUI | `Win+P` |
| **[Smile](https://github.com/mijorus/smile)** | Emoji picker | `Win+Period` |
| **[Brightnessctl](https://github.com/Hummer12007/brightnessctl)** | Backlight control | Hardware brightness keys |

## Repository Structure

```
niri-ultimate-config/
├── .github/workflows/     CI/CD validation pipeline
│   └── validate.yml       Runs niri validate, keyd check, shellcheck
├── niri/                  Niri compositor config → ~/.config/niri/
│   ├── config.kdl         Main config (sources cfg/ files)
│   └── cfg/
│       ├── keybinds.kdl   All keyboard shortcuts
│       ├── autostart.kdl  Startup applications
│       ├── animation.kdl  Window animations
│       ├── display.kdl    Monitor configuration
│       ├── input.kdl      Touchpad & keyboard settings
│       ├── layout.kdl     Tiling layout rules
│       ├── misc.kdl       Miscellaneous settings
│       └── rules.kdl      Window rules (floating, sizing)
├── noctalia/              Noctalia shell → ~/.config/noctalia/
├── keyd/
│   └── default.conf       Keyd layers config → /etc/keyd/
├── install.sh             Interactive installer (dry-run, backup, deps)
├── KEYBINDS.md            Full keybinding documentation
├── CONTRIBUTING.md        How to contribute
└── LICENSE
```

## Installation

### Quick Start

```bash
git clone https://github.com/John-Varghese-EH/niri-ultimate-config.git ~/.dotfiles
cd ~/.dotfiles
chmod +x install.sh
./install.sh
```

### Installer Features

The interactive installer handles everything:

```bash
# Full interactive install with guided setup
./install.sh

# Install everything + auto-install missing packages
./install.sh --all --install-deps

# Preview what would change without touching anything
./install.sh --dry-run

# Install only keyboard remapping (works on any Wayland/X11/TTY)
./install.sh --only-keyd

# Use your own apps instead of defaults
./install.sh --terminal kitty --browser firefox --file-manager thunar

# Cleanly remove everything and restore backups
./install.sh --uninstall
```

During the Keyd installation step, the installer will also offer a **Text Macro Wizard** - letting you set up your own `RightAlt+1/2/3/4/5` instant-type shortcuts for emails, URLs, or any text you use often.

## Validation & CI/CD

Every push and pull request is automatically validated:

| Check | What It Validates |
|---|---|
| `niri validate` | Ensures Niri config syntax is correct and all source includes resolve |
| `keyd check` | Validates keyd layer definitions, key names, and macro syntax |
| `shellcheck` | Lints `install.sh` for shell scripting best practices |

Run validation locally:

```bash
niri validate -c niri/config.kdl
keyd check keyd/default.conf
shellcheck install.sh
```

## Keybindings Documentation

The true power of this setup lies in its shortcuts. We have engineered a three-layer keyboard system that bridges Windows familiarity with Linux power.

 **[View the Complete Keybindings Reference →](KEYBINDS.md)**

## Contributing

Contributions are welcome! Please read [CONTRIBUTING.md](CONTRIBUTING.md) before submitting a PR.

## License

This project is licensed under the **GPL-3.0 License** - see [LICENSE](LICENSE) for details.

---

## About the Author

**John Varghese (J0X)**  
- **LinkedIn**: [/in/John--Varghese/](https://linkedin.com/in/John--Varghese/)  
- **GitHub**: [John-Varghese-EH](https://github.com/John-Varghese-EH)

<p align="center">
  <sub>If this setup helped you transition to Linux or leveled up your workflow, consider starring the repository on GitHub.</sub>
</p>
