# J0X Arch Setup Configurations

A highly customized and performance-oriented desktop environment based on CachyOS. This setup utilizes the Niri scrollable-tiling compositor, the Noctalia shell, and a curated selection of tools for development and security research.

## Core Components

- **Operating System**: CachyOS (Arch Linux optimized for performance)
- **Compositor**: Niri (Modern scrollable-tiling Wayland compositor)
- **Shell Interface**: Noctalia Shell (Sleek, minimal, and premium UI)
- **Bootloader**: Limine with custom premium dark theme
- **Design Philosophy**: Glassmorphism, fluid animations, and high-clarity typography

## Repository Structure

- `niri/`: Compositor configuration (`~/.config/niri/`)
- `noctalia/`: Shell configuration and styling (`~/.config/noctalia/`)
- `keyd/`: Hardware-level keyboard remapping configurations
- `install.sh`: Deployment script for symlinking configurations

## Keyboard Shortcuts

This environment is configured with a focus on workflow efficiency, combining standard Windows-familiar shortcuts with Niri's advanced tiling logic.

### Windows-Familiar Defaults
- **Win + L**: Lock Screen (Native Noctalia)
- **Win + E**: File Explorer (Nautilus)
- **Win + R**: Application Launcher
- **Win + X**: Session Management Menu
- **Alt + F4**: Close Active Window
- **Alt + Tab**: Navigate between windows
- **Ctrl + Shift + Esc**: Task Manager (btop)

For a complete and detailed list of all available shortcuts, please refer to the [Keybindings Documentation](KEYBINDS.md).

## Installation

This setup is tailored for specific hardware and workflows. Please review the configurations before deployment.

```bash
# 1. Clone the repository with submodules
git clone --recurse-submodules https://github.com/John-Varghese-EH/J0X-Arch-Setup-Configs.git ~/.dotfiles
cd ~/.dotfiles

# 2. Make the installer executable
chmod +x install.sh

# 3. Run the installer to deploy configurations
./install.sh
```

## Maintenance and Updates

When modifying configurations:
- All keybind changes should be reflected in `niri/cfg/keybinds.kdl`.
- Shell aesthetics are managed through `noctalia/settings.json`.
- Ensure new configurations are added to `install.sh` for persistent symlinking.
