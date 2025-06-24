#!/usr/bin/env bash

# Colors for output
GREEN='\033[0;32m'
BLUE='\033[0;34m'
RED='\033[0;31m'
NC='\033[0m' # No Color

check_command() {
    if command -v $1 >/dev/null 2>&1; then
        echo -e "${GREEN}✓${NC} $1 is installed"
        return 0
    else
        echo -e "${RED}✗${NC} $1 is not installed"
        return 1
    fi
}

check_nix_feature() {
    if nix-env --version | grep -q "nix-env.*2."; then
        if nix show-config | grep -q "$1 = true"; then
            echo -e "${GREEN}✓${NC} Nix feature $1 is enabled"
            return 0
        else
            echo -e "${RED}✗${NC} Nix feature $1 is not enabled"
            return 1
        fi
    else
        echo -e "${RED}✗${NC} Nix version is too old"
        return 1
    fi
}

echo "Checking system dependencies..."

# Check if running on NixOS
if [ -f "/etc/NIXOS" ]; then
    echo -e "\n${BLUE}Running on NixOS${NC}"
    
    # Check Nix features
    check_nix_feature "experimental-features"
    check_nix_feature "flakes"
    
    # Check Home Manager
    check_command "home-manager"
    
else
    echo -e "\n${BLUE}Running on traditional Linux${NC}"
    
    # Check Stow
    check_command "stow"
fi

# Check common dependencies
check_command "git"
check_command "nvim"
check_command "tmux"
check_command "zsh"

echo -e "\nDependency check complete!"
