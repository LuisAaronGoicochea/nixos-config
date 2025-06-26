#!/usr/bin/env bash

set -e

SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
BACKUP_DIR="$HOME/.config.backup.$(date +%Y%m%d_%H%M%S)"
CONFIG_DIR="$HOME/.config"

# Colors for output
GREEN='\033[0;32m'
BLUE='\033[0;34m'
RED='\033[0;31m'
YELLOW='\033[1;33m'
NC='\033[0m' # No Color

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

# Function to safely backup and remove existing config
backup_config() {
    local dir="$1"
    local config_path="$CONFIG_DIR/$dir"
    
    if [ -L "$config_path" ]; then
        rm "$config_path"
    elif [ -d "$config_path" ]; then
        echo -e "${BLUE}Backing up $dir${NC}"
        cp -r "$config_path" "$BACKUP_DIR/"
        rm -rf "$config_path"
    fi
}

# Function to verify and fix dotfile structure
verify_dotfile_structure() {
    local dir="$1"
    echo -e "${BLUE}Verifying structure for $dir...${NC}"
    
    # Skip if directory doesn't exist
    [ ! -d "$SCRIPT_DIR/$dir" ] && return
    
    # Check if we have files in the root that should be in .config
    if [ -d "$SCRIPT_DIR/$dir/lua" ] || [ -f "$SCRIPT_DIR/$dir/init.lua" ]; then
        echo -e "${YELLOW}Found files in root directory of $dir, fixing structure...${NC}"
        
        # Create temporary directory
        local temp_dir=$(mktemp -d)
        
        # Move current contents to temp
        mv "$SCRIPT_DIR/$dir"/* "$temp_dir/" 2>/dev/null || true
        mv "$SCRIPT_DIR/$dir"/.[!.]* "$temp_dir/" 2>/dev/null || true
        
        # Create proper structure
        mkdir -p "$SCRIPT_DIR/$dir/.config/$dir"
        
        # Move contents to proper location
        mv "$temp_dir"/* "$SCRIPT_DIR/$dir/.config/$dir/" 2>/dev/null || true
        mv "$temp_dir"/.[!.]* "$SCRIPT_DIR/$dir/.config/$dir/" 2>/dev/null || true
        
        # Cleanup
        rm -rf "$temp_dir"
        echo -e "${GREEN}Structure fixed for $dir${NC}"
    fi
}

# Function to safely stow a directory
stow_config() {
    local dir="$1"
    echo -e "${BLUE}Installing $dir configuration...${NC}"
    
    # First verify and fix structure
    verify_dotfile_structure "$dir"
    
    # Backup any existing non-symlinked config files
    if [ -f "$HOME/.${dir}rc" ] && [ ! -L "$HOME/.${dir}rc" ]; then
        echo -e "${BLUE}Backing up .$dir""rc${NC}"
        mv "$HOME/.${dir}rc" "$BACKUP_DIR/"
    fi
    
    # Try to stow
    if ! stow --no-folding -t "$HOME" "$dir" 2>/dev/null; then
        echo -e "${YELLOW}Initial stow failed, attempting to fix...${NC}"
        
        # Create necessary directories
        mkdir -p "$CONFIG_DIR/$dir"
        
        # Try adopt mode first
        if stow --no-folding --adopt -t "$HOME" "$dir" 2>/dev/null; then
            echo -e "${GREEN}Successfully adopted existing files for $dir${NC}"
        else
            # If adopt fails, try to handle conflicts
            echo -e "${RED}Failed to stow $dir. Checking for conflicts...${NC}"
            stow --no-folding -t "$HOME" "$dir" 2>&1 | while read -r line; do
                if [[ $line =~ "existing target is" ]]; then
                    local file=$(echo "$line" | grep -o '[^[:space:]]*$')
                    if [ -f "$HOME/$file" ]; then
                        echo -e "${YELLOW}Moving conflicting file: $file${NC}"
                        mv "$HOME/$file" "$BACKUP_DIR/"
                    fi
                fi
            done
            
            # Try stow one final time
            if stow --no-folding -t "$HOME" "$dir" 2>/dev/null; then
                echo -e "${GREEN}Successfully stowed $dir after fixing conflicts${NC}"
            else
                echo -e "${RED}Failed to stow $dir. Please check the files manually${NC}"
                return 1
            fi
        fi
    else
        echo -e "${GREEN}Successfully stowed $dir${NC}"
    fi
}

# Function to setup NixOS configuration
setup_nixos() {
    echo -e "${BLUE}Setting up NixOS configuration...${NC}"
    
    # First, verify flake and nix configuration
    if [ ! -f "/etc/nixos/nix/flake.nix" ]; then
        echo -e "${YELLOW}Main NixOS flake not found in /etc/nixos/nix${NC}"
        echo -e "${BLUE}Would you like to copy the default flake configuration? [Y/n]${NC}"
        read -r response
        if [[ ! "$response" =~ ^[Nn]$ ]]; then
            # Create backup of existing configuration
            if [ -d "/etc/nixos/nix" ]; then
                echo -e "${BLUE}Backing up existing NixOS configuration...${NC}"
                sudo cp -r /etc/nixos/nix "/etc/nixos/nix.backup.$(date +%Y%m%d_%H%M%S)"
            fi

            # Copy all NixOS configuration
            echo -e "${BLUE}Copying NixOS configuration...${NC}"
            sudo cp -r "$SCRIPT_DIR/../nix" "/etc/nixos/"
            echo -e "${GREEN}NixOS configuration copied successfully!${NC}"
        else
            echo -e "${BLUE}Skipping NixOS configuration copy...${NC}"
        fi
    else
        echo -e "${GREEN}NixOS flake found in /etc/nixos/nix${NC}"
    fi

    # Check if home-manager is installed
    if ! command -v home-manager >/dev/null 2>&1; then
        echo -e "${YELLOW}Home Manager not found. Installing...${NC}"
        nix-channel --add https://github.com/nix-community/home-manager/archive/master.tar.gz home-manager
        nix-channel --update
        nix-shell '<home-manager>' -A install
    fi

    # Verify flake
    echo -e "${BLUE}Verifying NixOS flake...${NC}"
    if ! nix flake check /etc/nixos/nix 2>/dev/null; then
        echo -e "${RED}Warning: Flake check failed. Your flake might have issues.${NC}"
        echo -e "${YELLOW}You might want to review the configuration before proceeding.${NC}"
    else
        echo -e "${GREEN}Flake check passed!${NC}"
    fi

    # Handle dotfiles nix.conf if it exists
    if [ -f "$SCRIPT_DIR/nix/nix.conf" ]; then
        echo -e "${BLUE}Found nix.conf in dotfiles, installing...${NC}"
        if sudo mkdir -p /etc/nix && sudo cp "$SCRIPT_DIR/nix/nix.conf" "/etc/nix/nix.conf"; then
            echo -e "${GREEN}Installed nix.conf${NC}"
        else
            echo -e "${RED}Failed to install nix.conf${NC}"
        fi
    fi

    echo -e "${GREEN}NixOS configuration setup complete!${NC}"
    echo -e "${BLUE}Next steps:${NC}"
    echo "1. Review the configuration:"
    echo "   - Main NixOS config: /etc/nixos/nix/configuration.nix"
    echo "   - Home Manager config: /etc/nixos/nix/home-manager.nix"
    echo "   - Flake: /etc/nixos/nix/flake.nix"
    echo "2. Run: sudo nixos-rebuild switch --flake /etc/nixos/nix#"
    echo "3. Run: home-manager switch"
    
    # Warn about potential conflicts
    echo -e "${YELLOW}Note: If you plan to use both Home Manager and stow:${NC}"
    echo "- Home Manager should manage system-level configuration"
    echo "- Stow can manage additional user-specific dotfiles"
    echo "- Be careful not to manage the same files with both"
}

# Function to setup other distros configuration
setup_other_distro() {
    echo -e "${BLUE}Setting up configuration using GNU Stow...${NC}"

    # Check if stow is installed
    if ! command -v stow >/dev/null 2>&1; then
        echo -e "${RED}Error: GNU Stow is not installed${NC}"
        echo "Please install it with your package manager:"
        echo "  - Debian/Ubuntu: sudo apt install stow"
        echo "  - Fedora: sudo dnf install stow"
        echo "  - Arch Linux: sudo pacman -S stow"
        exit 1
    fi

    # Create necessary directories
    mkdir -p "$BACKUP_DIR"
    mkdir -p "$CONFIG_DIR"

    # Stow each directory
    for dir in "${STOW_DIRS[@]}"; do
        if [ -d "$SCRIPT_DIR/$dir" ]; then
            backup_config "$dir"
            stow_config "$dir"
        else
            echo -e "${RED}Warning: Directory $dir not found, skipping...${NC}"
        fi
    done

    echo -e "${GREEN}Configuration setup complete!${NC}"
    echo -e "${BLUE}Your previous configurations have been backed up to: ${BACKUP_DIR}${NC}"
}

# Main script
echo -e "${BLUE}Dotfiles Installation${NC}"
echo -e "${BLUE}====================${NC}\n"

# Create necessary directories
mkdir -p "$BACKUP_DIR"
mkdir -p "$CONFIG_DIR"

if [ -f "/etc/NIXOS" ]; then
    echo -e "${BLUE}NixOS detected!${NC}"
    setup_nixos
    
    echo -e "${BLUE}Would you like to also stow some dotfiles? [y/N]${NC}"
    read -r response
    if [[ "$response" =~ ^[Yy]$ ]]; then
        echo -e "${YELLOW}Note: Be careful not to conflict with Home Manager${NC}"
        setup_other_distro
    fi
else
    echo -e "${BLUE}Non-NixOS system detected!${NC}"
    setup_other_distro
fi

# Optional: Set zsh as default shell
if command -v zsh >/dev/null 2>&1; then
    if [ "$SHELL" != "$(which zsh)" ]; then
        # Check if we can change the shell for this user
        current_user=$(whoami)
        if ! grep -q "^${current_user}:" /etc/passwd; then
            echo -e "${RED}Cannot change shell: User $current_user not found in /etc/passwd${NC}"
            echo -e "${BLUE}If you're using NixOS, configure your shell in configuration.nix instead:${NC}"
            echo "users.users.$current_user.shell = pkgs.zsh;"
        else
            echo -e "${BLUE}Would you like to set zsh as your default shell? [y/N]${NC}"
            read -r response
            if [[ "$response" =~ ^[Yy]$ ]]; then
                if chsh -s "$(which zsh)"; then
                    echo -e "${GREEN}Shell changed to zsh. Please log out and back in for changes to take effect.${NC}"
                else
                    echo -e "${RED}Failed to change shell. Try running: ${NC}"
                    echo "sudo chsh -s $(which zsh) $current_user"
                fi
            fi
        fi
    fi
fi
