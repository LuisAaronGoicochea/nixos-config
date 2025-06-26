#!/usr/bin/env bash

# Colors for output
GREEN='\033[0;32m'
RED='\033[0;31m'
BLUE='\033[0;34m'
NC='\033[0m' # No Color

check_symlink() {
    local source="$1"
    local target="$2"
    if [ -L "$target" ]; then
        local current_source="$(readlink "$target")"
        if [[ "$current_source" == *"$source"* ]]; then
            echo -e "${GREEN}✓${NC} $target -> $source"
            return 0
        else
            echo -e "${RED}✗${NC} $target points to $current_source instead of $source"
            return 1
        fi
    else
        if [ -e "$target" ]; then
            echo -e "${RED}✗${NC} $target exists but is not a symlink"
        else
            echo -e "${RED}✗${NC} $target does not exist"
        fi
        return 1
    fi
}

check_command() {
    local cmd="$1"
    if command -v "$cmd" >/dev/null 2>&1; then
        echo -e "${GREEN}✓${NC} $cmd is installed"
        return 0
    else
        echo -e "${RED}✗${NC} $cmd is not installed"
        return 1
    fi
}

check_directory() {
    local dir="$1"
    if [ -d "$dir" ]; then
        echo -e "${GREEN}✓${NC} Directory $dir exists"
        return 0
    else
        echo -e "${RED}✗${NC} Directory $dir does not exist"
        return 1
    fi
}

echo -e "\n${BLUE}Checking Command Line Tools...${NC}"
tools=(
    "zsh"
    "nvim"
    "tmux"
    "fzf"
    "ripgrep"
    "bat"
    "eza"
    "fd"
    "starship"
    "git"
)

for tool in "${tools[@]}"; do
    check_command "$tool"
done

echo -e "\n${BLUE}Checking Configuration Files...${NC}"

# Check ZSH configuration
check_symlink ".zshrc" "$HOME/.zshrc"
check_symlink "zsh" "$HOME/.config/zsh"

# Check Neovim configuration
check_symlink "nvim" "$HOME/.config/nvim"

# Check Tmux configuration
check_symlink "tmux.conf" "$HOME/.tmux.conf"
check_symlink "tmux" "$HOME/.config/tmux"

# Check Starship configuration
check_symlink "starship.toml" "$HOME/.config/starship.toml"

# Check Git configuration
check_symlink ".gitconfig" "$HOME/.gitconfig"

# Check if shell is zsh
if [[ "$SHELL" == *"zsh"* ]]; then
    echo -e "${GREEN}✓${NC} Current shell is ZSH"
else
    echo -e "${RED}✗${NC} Current shell is not ZSH ($SHELL)"
fi

# Check if starship is in shell init
if grep -q "starship" "$HOME/.zshrc" 2>/dev/null; then
    echo -e "${GREEN}✓${NC} Starship is configured in shell"
else
    echo -e "${RED}✗${NC} Starship is not configured in shell"
fi

# If we're in NixOS, check flake status
if command -v nixos-version >/dev/null 2>&1; then
    echo -e "\n${BLUE}Checking NixOS Configuration...${NC}"
    if nix flake check /etc/nixos/nix 2>/dev/null; then
        echo -e "${GREEN}✓${NC} NixOS flake configuration is valid"
    else
        echo -e "${RED}✗${NC} NixOS flake configuration has errors"
    fi
fi

# Check optional tools based on what's in your dotfiles
echo -e "\n${BLUE}Checking Optional Tools...${NC}"
optional_tools=(
    "atuin"
    "nushell"
    "zellij"
)

for tool in "${optional_tools[@]}"; do
    if [ -d "$HOME/.config/$tool" ]; then
        check_command "$tool"
        check_symlink "$tool" "$HOME/.config/$tool"
    fi
done

echo -e "\n${BLUE}Done checking configuration${NC}"
