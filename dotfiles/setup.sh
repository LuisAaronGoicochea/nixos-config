#!/usr/bin/env bash

set -e

SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
BACKUP_DIR="$HOME/.config.backup.$(date +%Y%m%d_%H%M%S)"

# Colors for output
GREEN='\033[0;32m'
BLUE='\033[0;34m'
RED='\033[0;31m'
NC='\033[0m' # No Color

echo -e "${BLUE}Starting dotfiles installation...${NC}"

# Check if stow is installed
if ! command -v stow >/dev/null 2>&1; then
    echo -e "${RED}Error: GNU Stow is not installed${NC}"
    echo "Please install it with your package manager:"
    echo "  - Debian/Ubuntu: sudo apt install stow"
    echo "  - Fedora: sudo dnf install stow"
    echo "  - Arch Linux: sudo pacman -S stow"
    exit 1
fi

# Create backup of existing configs
echo -e "${BLUE}Backing up existing configurations to ${BACKUP_DIR}${NC}"
mkdir -p "$BACKUP_DIR"

# List of directories to stow
STOW_DIRS=(
    "aerospace"
    "atuin"
    "ghostty"
    "hammerspoon"
    "karabiner"
    "nushell"
    "nvim"
    "sketchybar"
    "skhd"
    "ssh"
    "starship"
    "tmux"
    "wezterm"
    "zellij"
    "zshrc"
)

# Backup and stow each configuration
for dir in "${STOW_DIRS[@]}"; do
    if [ -d "$HOME/.config/$dir" ]; then
        echo -e "${BLUE}Backing up $dir${NC}"
        cp -r "$HOME/.config/$dir" "$BACKUP_DIR/"
        rm -rf "$HOME/.config/$dir"
    fi
    
    echo -e "${BLUE}Installing $dir configuration...${NC}"
    stow -t "$HOME" "$dir"
done

echo -e "${GREEN}Installation complete!${NC}"
echo -e "${BLUE}Your previous configurations have been backed up to: ${BACKUP_DIR}${NC}"
