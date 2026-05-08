# Keybindings Documentation

This document provides a comprehensive list of keyboard shortcuts for the Niri compositor and Noctalia shell environment. The configuration is designed to balance Windows-familiar shortcuts with the powerful tiling capabilities of Niri.

## Modifiers
- **Mod**: Super / Windows key
- **Alt**: Standard Alt key
- **Ctrl**: Standard Control key

---

## Windows-Familiar Shortcuts
These shortcuts are mapped to match standard Windows behavior for ease of transition.

| Keybinding | Action |
| :--- | :--- |
| **Mod + L** | Lock Screen |
| **Mod + E** | File Explorer (Nautilus) |
| **Mod + X** | Session / Power Menu |
| **Mod + R** | Application Launcher |
| **Mod + V** | Clipboard History |
| **Mod + Period** | Emoji Picker |
| **Mod + Up** | Maximize Column |
| **Mod + Down** | Focus Window Down |
| **Alt + Tab** | Focus Column Right (Task Switching) |
| **Alt + F4** | Close Active Window |
| **Ctrl + Shift + Esc** | Task Manager (btop) |
| **Ctrl + Alt + T** | Terminal (Alacritty) |
| **Print** | Screenshot (Area Selection) |

---

## Window Management
Shortcuts for controlling window states and tiling behavior.

| Keybinding | Action |
| :--- | :--- |
| **Mod + Q** | Close Window |
| **Mod + F / Mod + Up** | Maximize Column |
| **Mod + M** | Maximize Window to Edges |
| **Mod + Shift + F** | Toggle Fullscreen |
| **Mod + T** | Toggle Floating State |
| **Mod + W** | Toggle Tabbed Display for Column |
| **Mod + D** | Toggle Overview (Show Desktop) |
| **Mod + C** | Center Active Column |

---

## Navigation and Tiling
Advanced navigation for Niri's scrollable tiling layout.

### Column Focus
- **Mod + Left / Right**: Focus column left/right
- **Mod + H / L**: Focus column left/right (Vim-style)
- **Mod + Home / End**: Focus first/last column

### Window Focus (Within Column)
- **Mod + Up / Down**: Focus window up/down
- **Mod + J / K**: Focus window up/down (Vim-style)

### Moving Elements
- **Mod + Alt + Left / Right**: Move column left/right
- **Mod + Ctrl + H / L**: Move column left/right
- **Mod + Alt + Up / Down**: Move window up/down within column
- **Mod + Ctrl + J / K**: Move window up/down

---

## Workspaces and Monitors
Management of virtual desktops and multi-monitor setups.

| Keybinding | Action |
| :--- | :--- |
| **Mod + 1-9** | Switch to Workspace 1-9 |
| **Mod + Ctrl + 1-9** | Move Column to Workspace 1-9 |
| **Mod + Ctrl + Left / Right** | Switch Workspace Up/Down |
| **Mod + Wheel Scroll** | Navigate Workspaces (Vertical) or Columns (Horizontal) |
| **Mod + Shift + Arrows** | Focus Monitor (Left/Right/Up/Down) |
| **Mod + Shift + Ctrl + Arrows** | Move Column to Monitor |

---

## System Utilities
Helper tools and system-level controls.

| Keybinding | Action |
| :--- | :--- |
| **Mod + P** | Display Configuration (wdisplays) |
| **Mod + Shift + W** | Reload Waybar |
| **Mod + Shift + P** | Power Off Monitors |
| **Mod + F1** | Show Hotkey Overlay |
| **Mod + Escape** | Toggle Shortcut Inhibition (for Games/VMs) |
| **Ctrl + Alt + Delete** | Quit Niri Session |

---

## Media and Hardware
Direct control for audio and brightness via hardware keys.

| Key | Action |
| :--- | :--- |
| **XF86AudioRaise/Lower** | System Volume Control |
| **XF86AudioMute/MicMute** | Mute Audio Output/Input |
| **XF86AudioPlay/Pause/Next/Prev** | Media Transport Controls |
| **XF86MonBrightnessUp/Down** | Screen Brightness Control |
