#!/usr/bin/env bash

# Colors for output
GREEN='\033[0;32m'
BLUE='\033[0;34m'
RED='\033[0;31m'
YELLOW='\033[1;33m'
NC='\033[0m'

print_header() {
    echo -e "\n${BLUE}=== $1 ===${NC}\n"
}

check_command() {
    if command -v $1 >/dev/null 2>&1; then
        echo -e "${GREEN}✓${NC} $1"
        return 0
    else
        echo -e "${RED}✗${NC} $1"
        return 1
    fi
}

check_optional_command() {
    if command -v $1 >/dev/null 2>&1; then
        echo -e "${GREEN}✓${NC} $1"
    else
        echo -e "${YELLOW}?${NC} $1 (opcional)"
    fi
}

check_file() {
    if [ -f "$1" ]; then
        echo -e "${GREEN}✓${NC} $1"
        return 0
    else
        echo -e "${RED}✗${NC} $1"
        return 1
    fi
}

print_header "Verificación del Sistema"

# Detectar el sistema operativo
if [ -f "/etc/NIXOS" ]; then
    echo -e "${BLUE}Sistema detectado: NixOS${NC}"
    
    print_header "Verificando requisitos de NixOS"
    check_command "nix"
    check_command "home-manager"
    
    print_header "Verificando configuración de Nix"
    if grep -q "experimental-features.*flakes" /etc/nixos/configuration.nix; then
        echo -e "${GREEN}✓${NC} Flakes habilitados"
    else
        echo -e "${RED}✗${NC} Flakes no habilitados"
    fi
    
else
    echo -e "${BLUE}Sistema detectado: Distribución Linux tradicional${NC}"
    
    print_header "Verificando requisitos básicos"
    check_command "stow"
    check_command "git"
fi

print_header "Verificando herramientas comunes"
check_command "zsh"
check_command "tmux"
check_command "nvim"
check_optional_command "starship"
check_optional_command "fzf"
check_optional_command "ripgrep"

print_header "Verificando configuraciones"
check_file "$HOME/.zshrc"
check_file "$HOME/.tmux.conf"
check_file "$HOME/.config/nvim/init.lua"

echo -e "\n${BLUE}Verificación completada!${NC}"
