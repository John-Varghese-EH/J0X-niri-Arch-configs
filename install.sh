#!/usr/bin/env bash

# J0X's CachyOS Setup - Installation Script
# This script symlinks configurations and allows for modular installation.

set -e

DOTFILES_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"

# --- Default Customizations ---
TERMINAL="${TERMINAL:-alacritty}"
BROWSER="${BROWSER:-helium}"
FILE_MANAGER="${FILE_MANAGER:-nautilus}"

# Components to install
INSTALL_NIRI=true
INSTALL_NOCTALIA=true
INSTALL_KEYD=true

usage() {
    echo "Usage: $0 [options]"
    echo "Options:"
    echo "  --terminal <cmd>      Set preferred terminal (default: $TERMINAL)"
    echo "  --browser <cmd>       Set preferred browser (default: $BROWSER)"
    echo "  --file-manager <cmd>  Set preferred file manager (default: $FILE_MANAGER)"
    echo "  --only-niri           Install only Niri configurations"
    echo "  --only-noctalia       Install only Noctalia configurations"
    echo "  --only-keyd           Install only Keyd configurations"
    echo "  --non-interactive     Skip confirmation prompts and menus"
    echo "  -h, --help            Show this help message"
}

# Parse arguments
while [[ "$#" -gt 0 ]]; do
    case $1 in
        --terminal) TERMINAL="$2"; shift ;;
        --browser) BROWSER="$2"; shift ;;
        --file-manager) FILE_MANAGER="$2"; shift ;;
        --only-niri) INSTALL_NIRI=true; INSTALL_NOCTALIA=false; INSTALL_KEYD=false ;;
        --only-noctalia) INSTALL_NIRI=false; INSTALL_NOCTALIA=true; INSTALL_KEYD=false ;;
        --only-keyd) INSTALL_NIRI=false; INSTALL_NOCTALIA=false; INSTALL_KEYD=true ;;
        --non-interactive) NON_INTERACTIVE=true ;;
        -h|--help) usage; exit 0 ;;
        *) echo "Unknown parameter: $1"; usage; exit 1 ;;
    esac
    shift
done

echo "🌌 Starting J0X's CachyOS Setup 🌌"

# Interactive Selection Menu
if [[ -z "$NON_INTERACTIVE" && "$INSTALL_NIRI" == true && "$INSTALL_NOCTALIA" == true ]]; then
    echo "Which components would you like to install?"
    echo "1) All (Niri + Noctalia + Keyd)"
    echo "2) Only Niri"
    echo "3) Only Noctalia"
    echo "4) Only Keyd"
    read -p "Selection [1-4]: " choice
    case $choice in
        2) INSTALL_NOCTALIA=false; INSTALL_KEYD=false ;;
        3) INSTALL_NIRI=false; INSTALL_KEYD=false ;;
        4) INSTALL_NIRI=false; INSTALL_NOCTALIA=false ;;
        *) ;;
    esac
fi

echo "Configuration:"
echo "  Terminal:     $TERMINAL"
echo "  Browser:      $BROWSER"
echo "  File Manager: $FILE_MANAGER"
echo "  Installing:   $( [[ $INSTALL_NIRI == true ]] && echo -n "Niri " )$( [[ $INSTALL_NOCTALIA == true ]] && echo -n "Noctalia " )$( [[ $INSTALL_KEYD == true ]] && echo -n "Keyd" )"

if [[ -z "$NON_INTERACTIVE" ]]; then
    read -p "Continue with installation? (y/N) " -n 1 -r
    echo
    if [[ ! $REPLY =~ ^[Yy]$ ]]; then
        echo "Aborting."
        exit 1
    fi
fi

# Function to check if a command exists
check_cmd() {
    if ! command -v "$1" &> /dev/null; then
        echo "⚠️  Warning: Command '$1' not found. You might need to install it."
    fi
}

check_cmd "$TERMINAL"
check_cmd "$BROWSER"
check_cmd "$FILE_MANAGER"

# Function to safely symlink files and directories
link_config() {
    local source_name="$1"
    local target_parent="$2"
    local source_path="$DOTFILES_DIR/$source_name"
    local target_path="$target_parent/$(basename "$source_name")"

    if [ ! -e "$source_path" ]; then
        echo "⚠️  Warning: Source $source_path does not exist. Skipping."
        return
    fi

    mkdir -p "$target_parent"
    
    if [ -e "$target_path" ] || [ -L "$target_path" ]; then
        local backup_path="$target_path.backup-$(date +%s)"
        echo "📦 Backing up existing config to $backup_path"
        mv "$target_path" "$backup_path"
    fi

    ln -s "$source_path" "$target_path"
    echo "✅ Linked $source_name -> $target_path"
}

# Apply customizations to KDL files
customize_configs() {
    echo "Applying customizations to local configurations..."
    # Update Terminal
    find "$DOTFILES_DIR/niri" -type f -name "*.kdl" -exec sed -i "s/spawn \"alacritty\"/spawn \"$TERMINAL\"/g" {} +
    # Update Browser
    find "$DOTFILES_DIR/niri" -type f -name "*.kdl" -exec sed -i "s/spawn \"helium\"/spawn \"$BROWSER\"/g" {} +
    # Update File Manager
    find "$DOTFILES_DIR/niri" -type f -name "*.kdl" -exec sed -i "s/spawn \"nautilus\"/spawn \"$FILE_MANAGER\"/g" {} +
    
    # Also update titles in hotkey-overlay
    find "$DOTFILES_DIR/niri" -type f -name "*.kdl" -exec sed -i "s/Terminal: alacritty/Terminal: $TERMINAL/g" {} +
    find "$DOTFILES_DIR/niri" -type f -name "*.kdl" -exec sed -i "s/Browser: helium/Browser: $BROWSER/g" {} +
    find "$DOTFILES_DIR/niri" -type f -name "*.kdl" -exec sed -i "s/Manager: nautilus/Manager: $FILE_MANAGER/g" {} +
}

# Perform installation
if [[ "$INSTALL_NIRI" == true ]]; then
    customize_configs
    echo "Linking Niri configurations..."
    link_config "niri" "$HOME/.config"
fi

if [[ "$INSTALL_NOCTALIA" == true ]]; then
    echo "Linking Noctalia configurations..."
    link_config "noctalia" "$HOME/.config"
fi

if [[ "$INSTALL_KEYD" == true ]]; then
    echo "Linking Keyd configurations..."
    echo "Note: Keyd typically requires root permissions to link to /etc/keyd."
    if [[ "$EUID" -ne 0 && -z "$NON_INTERACTIVE" ]]; then
        read -p "Would you like to use sudo to link keyd config? (y/N) " -n 1 -r
        echo
        if [[ $REPLY =~ ^[Yy]$ ]]; then
            sudo mkdir -p /etc/keyd
            sudo ln -sf "$DOTFILES_DIR/keyd/default.conf" /etc/keyd/default.conf
            echo "✅ Linked keyd -> /etc/keyd/default.conf"
        else
            echo "⏭️  Skipping Keyd (requires root)."
        fi
    elif [[ "$EUID" -eq 0 ]]; then
        mkdir -p /etc/keyd
        ln -sf "$DOTFILES_DIR/keyd/default.conf" /etc/keyd/default.conf
        echo "✅ Linked keyd -> /etc/keyd/default.conf"
    fi
fi

echo "Note: Limine bootloader themes should be installed manually to the EFI partition."
echo "Check the limine/ directory for instructions and assets."

echo "🎉 Setup complete! Remember to restart affected services or your compositor."
