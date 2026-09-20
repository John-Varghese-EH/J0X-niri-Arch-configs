# Keybindings and Layers Reference

A comprehensive reference for the three-layer keyboard system powering this Arch Linux setup.

This configuration combines the scrollable-tiling window management of **Niri**, the kernel-level key remapping of **Keyd**, and the Wayland input injection of **Ydotool** into a unified shortcut architecture designed to feel immediately familiar to anyone transitioning from Windows.

---

## Layer Architecture Overview

This setup operates on three distinct keyboard layers that work together seamlessly:

| Layer | Activation | Engine | Scope |
|---|---|---|---|
| **Base Layer** | Always active | Keyd | CapsLock, Shift, and Meta key overloads |
| **Navigation Layer** | Hold `RightAlt` | Keyd | Arrow keys, numpad, media, text macros |
| **Mouse Control Layer** | Hold `RightAlt + LeftShift` | Keyd + Ydotool | Full cursor movement and click injection |

All three layers operate at the kernel level through Keyd, meaning they work universally across every application, terminal, browser, and even virtual machines.

---

## 1. Keyd Base Layer: Modifier Overloads

These remappings are always active and fundamentally upgrade the ergonomics of a standard keyboard layout.

| Physical Key | Tap Action | Hold Action | Rationale |
|---|---|---|---|
| **CapsLock** | `Escape` | `Control` | Eliminates the reach to the corner for Escape and brings Ctrl to the home row. |
| **Left Shift** | Types `(` | Regular Shift | Space Cadet behavior. Parentheses without leaving the home row. |
| **Right Shift** | Types `)` | Regular Shift | Completes the Space Cadet pair for rapid bracket entry. |
| **Super / Win** | Opens App Launcher | Regular Super | Tap to launch applications, hold for standard Win+key combos. |
| **Right Alt** | Activates Navigation Layer | (Layer toggle) | Transforms the right half of the keyboard into a navigation and numpad cluster. |

### Extended Function Keys

Holding Shift with any function key produces the extended `F13-F24` range, which is invaluable for binding macros in applications like OBS, DaVinci Resolve, or any DAW.

| Shortcut | Output |
|---|---|
| `Shift + F1` through `Shift + F12` | `F13` through `F24` |

---

## 2. Navigation Layer (Hold RightAlt)

By holding **RightAlt** with your right thumb, the keyboard transforms into a compact control surface. Your hands never need to leave the home row.

### Arrow Keys and Page Navigation

| Key (while holding RightAlt) | Action | Notes |
|---|---|---|
| `W` | Up Arrow | WASD directional cluster |
| `A` | Left Arrow | |
| `S` | Down Arrow | |
| `D` | Right Arrow | |
| `Q` | Home | Jump to beginning of line |
| `E` | End | Jump to end of line |
| `R` | Page Up | Scroll up one page |
| `F` | Page Down | Scroll down one page |

### Virtual Numpad

A complete numpad mapped to the right-hand cluster. Eliminates the need for a full-size keyboard or an external numpad.

| Key (while holding RightAlt) | Output | Numpad Position |
|---|---|---|
| `U` | `7` | Top-left |
| `I` | `8` | Top-center |
| `O` | `9` | Top-right |
| `J` | `4` | Middle-left |
| `K` | `5` | Middle-center |
| `L` | `6` | Middle-right |
| `M` | `1` | Bottom-left |
| `,` | `2` | Bottom-center |
| `.` | `3` | Bottom-right |
| `Space` | `0` | Zero |
| `;` | `Enter` | Numpad Enter |
| `P` | `Backspace` | Correction key |
| `/` | `-` | Minus / Subtract |

### Media Controls

| Key (while holding RightAlt) | Action |
|---|---|
| `-` | Volume Down |
| `=` | Volume Up |
| `0` | Mute / Unmute |
| `[` | Previous Track |
| `]` | Next Track |
| `\` | Play / Pause |

### Text Expansion Macros

Instant-type shortcuts for frequently used text. These are fully customizable during installation via the Text Macro Wizard.

| Key (while holding RightAlt) | Default Output | Typical Use |
|---|---|---|
| `1` | `user@example.com` | Primary email address |
| `2` | `https://github.com/your-username` | GitHub profile URL |
| `3` | `https://linkedin.com/in/your-username/` | LinkedIn profile URL |
| `Z` | Unicode character insertion | Special character via `Ctrl+Shift+U` sequence |

> **Note:** The macro outputs above are placeholders. The installer prompts you to configure your own values during the Keyd setup phase.

---

## 3. Mouse Control Layer (Hold RightAlt + LeftShift)

Powered by **Ydotool**, this layer injects real cursor movement and click events at the Wayland protocol level. Useful for presentations, accessibility, or when your mouse is out of reach.

| Key (while holding RightAlt + LeftShift) | Action |
|---|---|
| `W` | Move cursor up |
| `A` | Move cursor left |
| `S` | Move cursor down |
| `D` | Move cursor right |
| `J` | Left mouse click |
| `K` | Right mouse click |

Cursor movement speed is controlled by the `ydotool mousemove` pixel delta in your Niri keybinds configuration (`~/.config/niri/cfg/keybinds.kdl`). The default is 25 pixels per keypress.

---

## 4. Windows-Familiar Shortcuts

These shortcuts are mapped in Niri to replicate the exact behavior of their Windows equivalents. If you have spent years building muscle memory on Windows, every one of these will feel instantly natural.

### Direct Windows Equivalents

The following table maps each shortcut to its identical Windows counterpart, so you know exactly which habits carry over without any retraining.

| Shortcut | Action | Windows Equivalent | Powered By |
|---|---|---|---|
| `Win + E` | Open File Explorer | Win + E (Explorer) | Nautilus |
| `Win + R` | Application Launcher | Win + R (Run Dialog) | Noctalia Shell |
| `Win + L` | Lock Screen | Win + L (Lock) | Noctalia Shell |
| `Win + X` | Power / Session Menu | Win + X (Quick Link Menu) | Noctalia Shell |
| `Win + P` | Display Configuration | Win + P (Project / Display) | Wdisplays |
| `Win + V` | Clipboard History | Win + V (Clipboard History) | Fuzzel + Cliphist |
| `Win + .` | Emoji Picker | Win + . (Emoji Panel) | Smile |
| `Win + Shift + S` | Area Screenshot | Win + Shift + S (Snipping Tool) | Niri Native |
| `Alt + F4` | Close Active Window | Alt + F4 (Close Window) | Niri Native |
| `Alt + Tab` | Switch Windows Forward | Alt + Tab (Task Switcher) | Niri Native |
| `Alt + Shift + Tab` | Switch Windows Backward | Alt + Shift + Tab (Reverse Switcher) | Niri Native |
| `Ctrl + Shift + Esc` | Task Manager | Ctrl + Shift + Esc (Task Manager) | Alacritty + Btop |
| `Ctrl + Alt + Delete` | Emergency Session Exit | Ctrl + Alt + Delete (Security Options) | Niri Native |
| `Win + D` | Show Desktop / Overview | Win + D (Show Desktop) | Niri Native |
| `Win + Up` | Maximize Window | Win + Up (Maximize) | Niri Native |
| `F11` | Toggle Fullscreen | F11 (Fullscreen in browsers) | Niri Native |
| `Win + 1-9` | Switch to Workspace | Win + 1-9 (Taskbar App) | Niri Native |
| `Win + Ctrl + Left/Right` | Switch Virtual Desktop | Win + Ctrl + Left/Right (Virtual Desktops) | Niri Native |
| `Print Screen` | Screenshot | Print Screen (Screenshot) | Niri Native |
| `Ctrl + Alt + T` | Open Terminal | (No direct equivalent) | Alacritty |
| `Win + Enter` | Open Terminal | (No direct equivalent) | Alacritty |

### Additional Application Shortcuts

| Shortcut | Action | Powered By |
|---|---|---|
| `Win + B` | Open Web Browser | Brave (configurable) |
| `Win + Space` | Application Launcher (alternate) | Noctalia Shell |
| `Alt + Space` | Application Launcher (alternate) | Noctalia Shell |

---

## 5. Niri Window Management

Niri uses a scrollable-tiling model. Windows are organized into columns that scroll horizontally, and each column can contain multiple vertically stacked windows.

### Window States

| Shortcut | Action |
|---|---|
| `Win + Q` | Close window |
| `Win + F` | Maximize column |
| `Win + Up` | Maximize column (alternate) |
| `Win + M` | Maximize window to edges |
| `Win + Shift + F` | Toggle fullscreen |
| `F11` | Toggle fullscreen (alternate) |
| `Win + T` | Toggle floating mode |
| `Win + D` | Toggle overview (show desktop) |
| `Win + Alt + O` | Toggle window opacity |

### Focus Navigation

| Shortcut | Action | Style |
|---|---|---|
| `Win + Left` | Focus column left | Arrow keys |
| `Win + Right` | Focus column right | Arrow keys |
| `Win + Up` | Maximize column | Arrow keys |
| `Win + Down` | Focus window down | Arrow keys |
| `Win + H` | Focus column left | Vim |
| `Win + J` | Focus window down | Vim |
| `Win + K` | Focus window up | Vim |
| `Win + Home` | Focus first column | |
| `Win + End` | Focus last column | |

> **Note:** `Win + L` is reserved for Lock Screen (matching Windows behavior). Vim-style rightward focus is available via `Win + Right`.

### Moving Windows and Columns

| Shortcut | Action |
|---|---|
| `Win + Alt + Left` | Move column left |
| `Win + Alt + Right` | Move column right |
| `Win + Alt + Up` | Move window up within column |
| `Win + Alt + Down` | Move window down within column |
| `Win + Alt + Home` | Move column to first position |
| `Win + Alt + End` | Move column to last position |
| `Ctrl + Alt + Left` | Move column left (alternate) |
| `Ctrl + Alt + Right` | Move column right (alternate) |
| `Win + Ctrl + H` | Move column left (Vim) |
| `Win + Ctrl + J` | Move window down (Vim) |
| `Win + Ctrl + K` | Move window up (Vim) |
| `Win + Ctrl + L` | Move column right (Vim) |

### Multi-Monitor Navigation

| Shortcut | Action |
|---|---|
| `Win + Shift + Left` | Focus monitor left |
| `Win + Shift + Right` | Focus monitor right |
| `Win + Shift + Up` | Focus monitor up |
| `Win + Shift + Down` | Focus monitor down |
| `Win + Ctrl + Shift + Left` | Move column to monitor left |
| `Win + Ctrl + Shift + Right` | Move column to monitor right |
| `Win + Ctrl + Shift + Up` | Move column to monitor up |
| `Win + Ctrl + Shift + Down` | Move column to monitor down |

---

## 6. Workspace Navigation

| Shortcut | Action |
|---|---|
| `Win + 1-9` | Switch to workspace 1 through 9 |
| `Win + Ctrl + 1-9` | Move current window to workspace 1 through 9 |
| `Win + Ctrl + Left` | Switch to previous workspace |
| `Win + Ctrl + Right` | Switch to next workspace |
| `Win + Page Up` | Focus workspace up |
| `Win + Page Down` | Focus workspace down |
| `Win + U / I` | Focus workspace down / up |
| `Win + Ctrl + U / I` | Move window to workspace down / up |
| `Win + Shift + U / I` | Move entire workspace down / up |
| `Win + Scroll Wheel` | Navigate workspaces and columns rapidly |
| `Win + Tab` | Focus previous workspace |

---

## 7. Layout and Resizing

| Shortcut | Action |
|---|---|
| `Win + C` | Center column on screen |
| `Win + Ctrl + C` | Center all visible columns |
| `Win + -` | Decrease column width by 10% |
| `Win + =` | Increase column width by 10% |
| `Win + Shift + -` | Decrease window height by 10% |
| `Win + Shift + =` | Increase window height by 10% |
| `Win + W` | Toggle column tabbed display |
| `Win + [` | Consume or expel window left |
| `Win + ]` | Consume or expel window right |
| `Win + ,` | Consume window into column |
| `Win + Shift + R` | Cycle preset column widths |
| `Win + Alt + R` | Cycle preset window heights |
| `Win + Ctrl + R` | Reset window height |
| `Win + Shift + V` | Switch focus between floating and tiling |
| `Win + Shift + Y` | Toggle sticky floating window |

---

## 8. System and Hardware

### Screenshots

| Shortcut | Action |
|---|---|
| `Win + Shift + S` | Area screenshot (Snipping Tool equivalent) |
| `Print Screen` | Area screenshot |
| `Ctrl + Print Screen` | Screenshot entire screen |
| `Alt + Print Screen` | Screenshot active window |
| `Ctrl + Shift + 1` | Area screenshot (alternate) |
| `Ctrl + Shift + 2` | Full screen screenshot (alternate) |
| `Ctrl + Shift + 3` | Window screenshot (alternate) |

### Hardware and Media Keys

All hardware keys function even when the screen is locked.

| Key | Action |
|---|---|
| Volume Up / Down | System volume control |
| Mute | Toggle audio output mute |
| Mic Mute | Toggle microphone mute |
| Play / Pause | Media playback control |
| Next / Previous | Media track navigation |
| Brightness Up / Down | Screen backlight control |
| Display Key (XF86Display) | Open display configuration |

### Utility Shortcuts

| Shortcut | Action |
|---|---|
| `Ctrl + Alt + T` | Open terminal |
| `Win + Alt + P` | Hardware dashboard (Nvidia, sensors, battery) |
| `Win + Shift + W` | Reload Waybar |
| `Win + Shift + P` | Power off monitors |
| `Win + Shift + /` | Show hotkey overlay |
| `Win + Shift + Esc` | Show hotkey overlay (alternate) |
| `Win + F1` | Show hotkey overlay (alternate) |
| `Win + Escape` | Toggle keyboard shortcut inhibition (for VMs and gaming) |
| `Ctrl + Alt + Delete` | Quit Niri session (emergency exit) |

---

## Quick Reference Card

The most frequently used shortcuts, consolidated for rapid scanning:

| Action | Shortcut |
|---|---|
| Open terminal | `Ctrl + Alt + T` |
| Open file explorer | `Win + E` |
| Launch application | `Win + R` or `Alt + Space` |
| Close window | `Alt + F4` or `Win + Q` |
| Lock screen | `Win + L` |
| Screenshot (area) | `Win + Shift + S` |
| Clipboard history | `Win + V` |
| Task manager | `Ctrl + Shift + Esc` |
| Toggle fullscreen | `F11` |
| Arrow keys (home row) | `RightAlt + WASD` |
| Numpad (home row) | `RightAlt + UIOJKL` |
| Mouse cursor control | `RightAlt + LeftShift + WASD` |
| Text macro | `RightAlt + 1/2/3` |

---

**Author:** John Varghese (J0X)
* **LinkedIn**: [/in/John--Varghese/](https://linkedin.com/in/John--Varghese/)
* **GitHub**: [John-Varghese-EH](https://github.com/John-Varghese-EH)
