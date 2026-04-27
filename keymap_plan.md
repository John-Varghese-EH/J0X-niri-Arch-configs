# Unified Hybrid Keymap Plan

The current configuration has a few conflicting bindings (like `Mod+T` trying to open a terminal while Niri expects it to toggle floating windows) and unintuitive navigation quirks (like `Mod+Up` maximizing a column, which breaks vertical focus for users unfamiliar with Vim bindings). 

This plan proposes a fully unified "Best of Both Worlds" keymap. It keeps your **Windows-familiar shortcuts** for apps and system controls, while restoring **Niri's native tiling navigation** so you don't lose core WM functionalities.

## Proposed Changes

### [MODIFY] `niri/cfg/keybinds.kdl` & `niri/config.kdl`

**1. Applications & System (Windows-Familiar)**
*   `Mod+E` ➔ File Manager
*   `Mod+B` ➔ Browser
*   `Mod+L` ➔ Lock Screen
*   `Ctrl+Shift+Escape` ➔ Task Manager
*   `Alt+Space` AND `Mod+R` ➔ App Launcher (Noctalia)
    *   *Note: We will remap Niri's `switch-preset-column-width` from `Mod+R` to `Mod+Shift+R` to free up `Mod+R` for the classic "Windows Run" feel.*
*   `Mod+Enter` AND `Ctrl+Alt+T` ➔ Terminal
    *   *Note: Replaces `Mod+T` so we can give `Mod+T` back to Niri's "toggle floating window" action.*
*   `Mod+D` ➔ Toggle Overview (Show Desktop)

**2. Window State & Sizing (Hybrid)**
*   `Mod+M` ➔ Maximize Column (Similar to Windows `Win+M`, but maximizes instead of minimize since tiling WMs don't typically minimize).
*   `F11` and `Mod+Shift+F` ➔ Fullscreen Window
*   `Mod+T` ➔ Toggle window floating
*   `Mod+W` ➔ Toggle column tabbed display

**3. Tiling & Navigation (Niri Native - Unbroken)**
*   `Mod+Left/Right` ➔ Focus column left/right
*   `Mod+Up/Down` ➔ Focus window up/down (Restored so you can navigate vertically without using Vim keys)
*   `Mod+Ctrl+Left/Right` ➔ Move column left/right
*   `Mod+Ctrl+Up/Down` ➔ Move window up/down
*   `Alt+Tab` / `Alt+Shift+Tab` ➔ Focus next/prev column (Kept for Windows muscle memory)

### [MODIFY] `README.md`
Update the keyboard shortcuts tables to reflect these finalized, conflict-free bindings.

## User Review Required

> [!IMPORTANT]
> Please review the proposed bindings above. By restoring `Mod+Up/Down` to focus windows, and moving `Maximize` to `Mod+M`, you retain full directional navigation while keeping your Windows muscle memory for launching apps. If you approve, I will execute these changes across your configurations and README!
