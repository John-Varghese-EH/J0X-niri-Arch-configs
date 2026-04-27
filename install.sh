#!/usr/bin/env bash

# J0X's CachyOS Setup - Installation Script
# This script symlinks configurations to their proper places.

set -e

DOTFILES_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"

echo "🌌 Starting J0X's CachyOS Setup 🌌"

# Function to safely symlink files and directories
link_config() {
    local source_path="$DOTFILES_DIR/$1"
    local target_dir="$2"
    local target_path="$target_dir/$(basename "$1")"

    if [ ! -e "$source_path" ]; then
        echo "⚠️  Warning: Source $source_path does not exist yet. Skipping."
        return
    fi

    mkdir -p "$target_dir"
    
    if [ -e "$target_path" ] || [ -L "$target_path" ]; then
        echo "Backup existing config: $target_path"
        mv "$target_path" "$target_path.backup-$(date +%s)"
    fi

    ln -s "$source_path" "$target_path"
    echo "✅ Linked $1 -> $target_path"
}

# ---------------------------------------------------------
# Deploy Configurations Below
# ---------------------------------------------------------

echo "Linking Niri configurations..."
link_config "niri" "$HOME/.config"

echo "Linking Nocria configurations..."
link_config "nocria" "$HOME/.config"

echo "Note: Limine bootloader themes should be installed manually to the EFI partition."
echo "Check the limine/ directory for instructions and assets."

echo "🎉 Setup complete! Remember to review backups and restart your compositor."
