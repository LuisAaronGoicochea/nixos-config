#!/usr/bin/env bash

set -e

# Colors for output
GREEN='\033[0;32m'
BLUE='\033[0;34m'
RED='\033[0;31m'
NC='\033[0m' # No Color

SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
CONFIG_DIR="$SCRIPT_DIR/config"
BACKUP_DIR="$HOME/.config.backup.$(date +%Y%m%d_%H%M%S)"

# Function to print colored messages
print_message() {
    echo -e "${BLUE}$1${NC}"
}

print_success() {
    echo -e "${GREEN}$1${NC}"
}

print_error() {
    echo -e "${RED}$1${NC}"
}

# Check if running on NixOS
is_nixos() {
    [ -f "/etc/NIXOS" ]
}

# Check if command exists
check_command() {
    if ! command -v "$1" &> /dev/null; then
        print_error "Error: $1 is not installed"
        return 1
    fi
}

# Backup existing configuration
backup_config() {
    local dir="$1"
    if [ -d "$HOME/.config/$dir" ]; then
        print_message "Backing up $dir configuration..."
        mkdir -p "$BACKUP_DIR"
        cp -r "$HOME/.config/$dir" "$BACKUP_DIR/"
    fi
}

# Install for NixOS
install_nixos() {
    print_message "Installing NixOS configuration..."
    
    # Check for required commands
    check_command "nix" || exit 1
    check_command "git" || exit 1
    
    # Copy NixOS configuration
    if [ -d "/etc/nixos" ]; then
        print_message "Backing up existing NixOS configuration..."
        sudo cp -r /etc/nixos "/etc/nixos.backup.$(date +%Y%m%d_%H%M%S)"
    fi
    
    # Copy new configuration
    print_message "Copying new NixOS configuration..."
    sudo cp -r "$SCRIPT_DIR/nix/"* /etc/nixos/
    
    # Rebuild NixOS
    print_message "Rebuilding NixOS..."
    sudo nixos-rebuild switch
    
    print_success "NixOS configuration installed successfully!"
}

# Install for other distributions
install_traditional() {
    print_message "Installing dotfiles using Stow..."
    
    # Check for required commands
    check_command "stow" || exit 1
    check_command "git" || exit 1
    
    # Create backup directory
    mkdir -p "$BACKUP_DIR"
    
    # List of configurations to install
    local configs=(
        "nvim"
        "tmux"
        "zsh"
        "starship"
        "git"
        # Add more configurations here
    )
    
    # Install each configuration
    for config in "${configs[@]}"; do
        print_message "Installing $config configuration..."
        backup_config "$config"
        stow -d "$CONFIG_DIR" -t "$HOME" "$config"
    done
    
    print_success "Dotfiles installed successfully!"
}

# Main installation logic
main() {
    print_message "Starting universal dotfiles installation..."
    
    if is_nixos; then
        print_message "Detected NixOS system"
        install_nixos
    else
        print_message "Detected traditional Linux distribution"
        install_traditional
    fi
    
    print_message "Installation complete!"
    if [ -d "$BACKUP_DIR" ]; then
        print_message "Your previous configurations have been backed up to: $BACKUP_DIR"
    fi
}

# Run the installer
main
