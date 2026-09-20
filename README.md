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

# The Ultimate Arch Linux Desktop for Windows Dual Booters

**Niri · Noctalia · Keyd · Ydotool — Production-grade Wayland dotfiles with CI/CD validation**

[![Validate Configs](https://github.com/John-Varghese-EH/niri-ultimate-config/actions/workflows/validate.yml/badge.svg)](https://github.com/John-Varghese-EH/niri-ultimate-config/actions/workflows/validate.yml)
[![License](https://img.shields.io/badge/license-GPL--3.0-blue.svg)](LICENSE)
![Niri](https://img.shields.io/badge/compositor-Niri-8B5CF6?logo=wayland)
![Arch Linux](https://img.shields.io/badge/platform-Arch%20Linux-1793D1?logo=archlinux&logoColor=white)
![Wayland](https://img.shields.io/badge/session-Wayland-4B8BBE)

[**Install**](#-installation) • [**Keybinds**](KEYBINDS.md) • [**Tools**](#%EF%B8%8F-the-tech-stack) • [**Contribute**](CONTRIBUTING.md)

---

## The Vision

This repository provides a complete, validated, and battle-tested desktop configuration designed specifically to make **Arch Linux feel like a supercharged version of Windows**. Every shortcut you already have hardwired into your muscle memory (`Win+E`, `Alt+F4`, `Ctrl+Shift+Esc`) works flawlessly out of the box, with powerful Linux-exclusive capabilities layered seamlessly on top.

This is not just a theme. It is a **production-grade workflow engine** featuring:

* **CI/CD Validated Configs:** Every single push is checked by `niri validate`, `keyd check`, and `shellcheck`.
* **Bulletproof Interactive Installer:** Complete with dry-run capabilities, automatic backup generation, full uninstallation support, and intelligent dependency management.
* **Custom Text Expansion Macros:** Configure your own snippets directly during installation.
* **Keyboard-Driven Mouse Control:** Precision cursor movement powered by `ydotool`.
* **Virtual Numpad Layer:** A full numpad right on your home row.

## Why This is the Best Niri Configuration

| Feature | How It Works |
|---|---|
| **Zero-Friction Windows Transition** | Native bindings for `Win+E`, `Alt+F4`, `Win+L`, `Ctrl+Shift+Esc`, `Win+V`, `Win+P`, `Alt+Tab`. |
| **Kernel-Level Key Remapping** | `keyd` safely overloads CapsLock to Esc/Ctrl, and adds deep navigation and numpad layers on RightAlt. |
| **Keyboard Mouse Control** | `ydotool` injects cursor movement cleanly via `RightAlt+Shift+WASD`. |
| **Text Expansion Macros** | Type your email, URLs, or signatures instantly using `RightAlt+1/2/3`. |
| **Space Cadet Shift** | Tap Left/Right Shift rapidly for `(`/`)` parentheses. |
| **Wayland Macro Fix** | Built-in `macro_sequence_timeout` strictly prevents character drops on Wayland. |
| **12 Extra Function Keys** | `Shift+F1-F12` maps directly to `F13-F24` for advanced app-specific shortcut mapping. |

## The Tech Stack

Every tool in this stack serves a specific, vital purpose. Nothing is purely decorative, and everything maps to an efficient keybind.

| Tool | Purpose | Triggered By |
|---|---|---|
| **[Niri](https://github.com/YaLTeR/niri)** | Scrollable-tiling Wayland compositor | Core Window Manager |
| **[Keyd](https://github.com/rvaiya/keyd)** | Kernel-level key remapping daemon | Always Active |
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

```text
niri-ultimate-config/
├── .github/workflows/     CI/CD validation pipeline
│   └── validate.yml       Runs niri validate, keyd check, shellcheck
├── niri/                  Niri compositor config -> ~/.config/niri/
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
├── noctalia/              Noctalia shell -> ~/.config/noctalia/
├── keyd/
│   └── default.conf       Keyd layers config -> /etc/keyd/
├── install.sh             Interactive installer (dry-run, backup, deps)
├── KEYBINDS.md            Full keybinding documentation
├── CONTRIBUTING.md        How to contribute
└── LICENSE
```

## Installation

### Quick Start

Execute the following commands to rapidly deploy the setup on your machine:

```bash
git clone https://github.com/John-Varghese-EH/niri-ultimate-config.git ~/.dotfiles
cd ~/.dotfiles
chmod +x install.sh
./install.sh
```

### Advanced Installer Features

The bespoke interactive installer handles all heavy lifting and supports extensive parameterization:

```bash
# Full interactive install with guided setup wizard
./install.sh

# Install absolutely everything and auto-install any missing packages
./install.sh --all --install-deps

# Preview exactly what would change without modifying your system
./install.sh --dry-run

# Isolate installation to keyboard remapping (compatible with any Wayland/X11/TTY environment)
./install.sh --only-keyd

# Override default applications with your preferred stack
./install.sh --terminal kitty --browser firefox --file-manager thunar

# Safely purge the configuration and seamlessly restore your original backups
./install.sh --uninstall
```

> [!NOTE]
> During the Keyd installation phase, the setup will invoke the **Text Macro Wizard**, empowering you to program your own `RightAlt+1/2/3/4/5` instant-type shortcuts for recurring text like emails, specific URLs, or terminal commands.

## Validation & CI/CD

Quality assurance is built into the core. Every push and pull request is automatically validated:

| Check | What It Validates |
|---|---|
| `niri validate` | Ensures Niri config syntax is pristine and all source includes resolve successfully. |
| `keyd check` | Validates keyd layer definitions, key nomenclature, and macro syntax. |
| `shellcheck` | Lints `install.sh` enforcing strict shell scripting best practices. |

To run the validation suite locally:

```bash
niri validate -c niri/config.kdl
keyd check keyd/default.conf
shellcheck install.sh
```

## Keybindings Documentation

The true leverage of this setup lies in its meticulously crafted shortcuts. We have engineered a three-layer keyboard system that seamlessly bridges Windows familiarity with unparalleled Linux power.

**[View the Complete Keybindings Reference](KEYBINDS.md)**

## Contributing

Contributions are heavily encouraged! Please review [CONTRIBUTING.md](CONTRIBUTING.md) prior to submitting a Pull Request.

## License

This architecture is distributed under the **GPL-3.0 License**. Reference the [LICENSE](LICENSE) file for complete terms and details.

---

## About the Author

**John Varghese (J0X)**  
* **LinkedIn**: [/in/John--Varghese/](https://linkedin.com/in/John--Varghese/)  
* **GitHub**: [John-Varghese-EH](https://github.com/John-Varghese-EH)

_If this setup helped you transition to Linux or leveled up your workflow, consider starring the repository on GitHub._
