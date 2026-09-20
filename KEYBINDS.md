# The Ultimate Keybindings & Layers Documentation

This document outlines the meticulously engineered keyboard shortcut ecosystem that powers this Arch Linux setup. 

By combining the window-management prowess of **Niri**, the hardware-level remapping of **Keyd**, and the input injection of **Ydotool**, this setup achieves unparalleled workflow efficiency.

---

## The "Keyd" Hardware Layers

We use **Keyd** to create advanced "layers" right on your keyboard, overriding the default behavior of your keys when specific modifiers are held.

### The Core Modifier Overloads
- **Caps Lock**: Acts as `Escape` when tapped, but acts as `Control` when held with another key.
- **Left Shift**: Acts as a regular shift, but types `(` when tapped quickly.
- **Right Shift**: Acts as a regular shift, but types `)` when tapped quickly.
- **Super / Meta**: Acts as `Super` when held, but opens your App Launcher (`Alt+Space`) when tapped.
- **Right Alt**: Activates the **Navigation Layer**.

### The Navigation Layer (Hold `Right Alt`)
By holding **Right Alt** with your right thumb, the rest of your keyboard transforms:

| Key | Action |
|---|---|
| **W, A, S, D** | Arrow Keys (Up, Left, Down, Right) |
| **Q, E** | Home, End |
| **R, F** | Page Up, Page Down |
| **U, I, O, J, K, L, M, Comma, Period** | **Full Numpad!** (7, 8, 9, 4, 5, 6, 1, 2, 3) |
| **Space** | Numpad 0 |
| **1, 2, 3** | Instant Text Expansion Macros (e.g., email, github urls) |
| **-, =, 0** | Volume Down, Volume Up, Mute |
| **[, ], \\** | Previous Track, Next Track, Play/Pause |

### Mouse Control Layer (Hold `Right Alt` + `Left Shift`)
*Powered by `Ydotool`!* If you hold both modifiers, you can drive your mouse cursor without ever touching your mouse.

| Key | Action |
|---|---|
| **W, A, S, D** | Move Cursor (Up, Left, Down, Right) |
| **J** | Left Mouse Click |
| **K** | Right Mouse Click |

*(Note: Cursor movement speed can be configured in your `~/.config/niri/cfg/keybinds.kdl` file).*

---

## Windows-Familiar Shortcuts (The "Dual-Booter" Defaults)
Transitioning to Linux shouldn't mean relearning everything. These Niri shortcuts are designed specifically to respect your Windows muscle memory.

| Shortcut | Action | Powered By |
|---|---|---|
| **Win + E** | File Explorer | Nautilus |
| **Win + R** | Application Launcher | Noctalia Shell |
| **Win + L** | Lock Screen | Noctalia Shell |
| **Win + X** | Power / Session Menu | Noctalia Shell |
| **Win + P** | Display Configuration | Wdisplays |
| **Win + V** | Clipboard History | Fuzzel & Cliphist |
| **Win + Period** | Emoji Picker | Smile |
| **Win + Shift + S** | Snipping Tool / Screenshot | Niri Native |
| **Alt + F4** | Close Active Window | Niri Native |
| **Alt + Tab** | Switch Windows (Focus Right) | Niri Native |
| **Ctrl + Shift + Esc** | Task Manager | Alacritty + Btop |

---

## Niri Tiling & Window Management
Master your workspace with Niri's advanced scrollable-tiling logic.

### Window States
| Shortcut | Action |
|---|---|
| **Win + Q** | Close Window |
| **Win + F / Win + Up** | Maximize Column |
| **Win + M** | Maximize Window to Edges |
| **Win + Shift + F** | Toggle Fullscreen |
| **Win + T** | Toggle Floating Window |
| **Win + D** | Toggle Overview (Show Desktop) |

### Navigation & Moving Elements
| Shortcut | Action |
|---|---|
| **Win + Left / Right** | Focus column left/right |
| **Win + H / L** | Focus column left/right (Vim-style) |
| **Win + Up / Down** | Focus window up/down within column |
| **Win + Alt + Left/Right** | Move column left/right |
| **Win + Alt + Up/Down**| Move window up/down within column |

### Workspaces
| Shortcut | Action |
|---|---|
| **Win + 1-9** | Switch to Workspace 1-9 |
| **Win + Ctrl + 1-9** | Move Column to Workspace 1-9 |
| **Win + Wheel Scroll**| Navigate Workspaces / Columns rapidly |

---

## System Utilities
Helper shortcuts mapped natively in Niri for system management.

| Shortcut | Action |
|---|---|
| **Ctrl + Alt + T** | Open Terminal |
| **Win + Alt + P** | Hardware Dashboard (Nvidia/Sensors monitor) |
| **Win + Shift + W** | Reload Waybar |
| **Win + Escape** | Toggle Shortcut Inhibition (Great for VMs and Gaming!) |
| **Ctrl + Alt + Delete**| Quit Niri Session / Emergency Exit |
