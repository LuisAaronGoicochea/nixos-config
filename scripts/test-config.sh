#!/usr/bin/env bash

set -e

# Colors for output
GREEN='\033[0;32m'
BLUE='\033[0;34m'
RED='\033[0;31m'
YELLOW='\033[1;33m'
NC='\033[0m'

SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"

print_header() {
    echo -e "\n${BLUE}=== $1 ===${NC}\n"
}

print_step() {
    echo -e "${YELLOW}$1${NC}"
}

print_success() {
    echo -e "${GREEN}✓ $1${NC}"
}

print_error() {
    echo -e "${RED}✗ $1${NC}"
    exit 1
}

# Verify NixOS configuration
test_nixos_config() {
    print_header "Probando configuración de NixOS"
    
    # Test flake.nix syntax
    print_step "Verificando sintaxis de flake.nix..."
    nix flake check || print_error "Error en flake.nix"
    print_success "flake.nix es válido"
    
    # Test configuration build
    print_step "Probando build de la configuración..."
    sudo nixos-rebuild build --flake .#nixos || print_error "Error en el build"
    print_success "Build exitoso"
}

# Test stow configuration
test_stow_config() {
    print_header "Probando configuración de Stow"
    
    # Create temporary directory for testing
    TEST_DIR=$(mktemp -d)
    print_step "Creando directorio temporal para pruebas: $TEST_DIR"
    
    # Try stowing files
    print_step "Probando stow en directorio temporal..."
    cd "$SCRIPT_DIR/dotfiles"
    stow -t "$TEST_DIR" --simulate * || print_error "Error en la prueba de stow"
    print_success "Prueba de stow exitosa"
    
    # Cleanup
    rm -rf "$TEST_DIR"
}

# Test shell configurations
test_shell_configs() {
    print_header "Probando configuraciones de shell"
    
    # Test zsh config
    if [ -f "$HOME/.zshrc" ]; then
        print_step "Verificando configuración de zsh..."
        zsh -c 'source ~/.zshrc' || print_error "Error en .zshrc"
        print_success "Configuración de zsh válida"
    fi
    
    # Test tmux config
    if [ -f "$HOME/.tmux.conf" ]; then
        print_step "Verificando configuración de tmux..."
        tmux new-session -d "tmux source ~/.tmux.conf" || print_error "Error en .tmux.conf"
        print_success "Configuración de tmux válida"
    fi
}

# Test neovim configuration
test_neovim_config() {
    print_header "Probando configuración de Neovim"
    
    if [ -f "$HOME/.config/nvim/init.lua" ]; then
        print_step "Verificando configuración de Neovim..."
        nvim --headless -c 'quit' || print_error "Error en la configuración de Neovim"
        print_success "Configuración de Neovim válida"
    fi
}

# Main testing function
main() {
    print_header "Iniciando pruebas de configuración"
    
    # Check if we're on NixOS
    if [ -f "/etc/NIXOS" ]; then
        test_nixos_config
    fi
    
    # Test stow configuration
    test_stow_config
    
    # Test specific configurations
    test_shell_configs
    test_neovim_config
    
    print_header "¡Todas las pruebas completadas exitosamente! 🎉"
}

# Run tests
main
