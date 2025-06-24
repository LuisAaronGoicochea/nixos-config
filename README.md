# 🚀 Universal Dotfiles

Este repositorio contiene una configuración universal de dotfiles que soporta tanto NixOS (con Home Manager) como distribuciones Linux tradicionales (usando GNU Stow).

## 📦 Características

- 🔄 **Soporte Dual**: Funciona tanto en NixOS como en otras distribuciones Linux
- 🏠 **Integración con Home Manager**: Configuración completa para NixOS
- 🔗 **GNU Stow**: Gestión de enlaces simbólicos para sistemas no-NixOS
- 🛠️ **Estructura Modular**: Fácil de personalizar y mantener
- 📚 **Bien Documentado**: Instrucciones claras para ambos modos de uso

## Features

- 🔧 **Dual-Mode Support**: Works with both NixOS and traditional Linux distributions
- 📦 **Home Manager Integration**: Full NixOS + Home Manager configuration
- 🔄 **GNU Stow Integration**: Easy symlink management for non-NixOS systems
- ⚡ **Modern Tools**: Configuration for modern development tools

## Installation

### Method 1: NixOS with Home Manager

#### Prerequisites
- NixOS installed
- Flakes enabled
- Home Manager installed

#### Steps

1. Clone este repositorio donde prefieras (por ejemplo, en tu carpeta de configuración):
   ```bash
   # Opción 1: En /etc/nixos (tradicional)
   sudo git clone https://github.com/LuisAaronGoicochea/nixos-config /etc/nixos

   # Opción 2: En tu directorio home
   git clone https://github.com/LuisAaronGoicochea/nixos-config ~/.config/nixos
   ```

2. Crea tu configuración personalizada:
   ```bash
   # Copia el ejemplo de configuración
   cp examples/configuration.nix ~/.config/nixos/config.nix
   
   # Edita la configuración según tus necesidades
   $EDITOR ~/.config/nixos/config.nix
   ```

3. Aplica la configuración:
   ```bash
   # Si instalaste en /etc/nixos
   sudo nixos-rebuild switch --flake .#nixos

   # Si instalaste en ~/.config/nixos
   sudo nixos-rebuild switch --flake ~/.config/nixos#nixos
   ```

#### Configuración Personalizada

El sistema es completamente modular. Puedes:

1. **Especificar tu ubicación preferida**:
   ```nix
   {
     configDir = "~/.config/nixos";  # O donde prefieras
   }
   ```

2. **Personalizar usuario y hostname**:
   ```nix
   {
     username = "tuusuario";
     hostname = "tumaquina";
   }
   ```

3. **Agregar módulos personalizados**:
   ```nix
   {
     extraModules = [
       ./modules/gaming.nix
       ./modules/development.nix
     ];
   }
   ``````

2. Copy NixOS configuration:
   ```bash
   sudo cp -r nix/* /etc/nixos/
   ```

3. Rebuild NixOS:
   ```bash
   sudo nixos-rebuild switch
   ```

### Method 2: Traditional Linux (Using GNU Stow)

#### Prerequisites
- GNU Stow
  ```bash
  # Debian/Ubuntu
  sudo apt install stow
  
  # Fedora
  sudo dnf install stow
  
  # Arch Linux
  sudo pacman -S stow
  ```

#### Steps
1. Clone this repository:
   ```bash
   git clone https://github.com/LuisAaronGoicochea/nixos-config
   cd nixos-config/dotfiles
   ```

2. Run the setup script:
   ```bash
   ./setup.sh
   ```

## Directory Structure

```
.
├── nix/                    # NixOS specific configurations
│   ├── configuration.nix   # System configuration
│   ├── flake.nix          # Flake configuration
│   └── home-manager.nix   # User configuration
│
└── dotfiles/              # Universal dotfiles (Stow-compatible)
    ├── aerospace/         # Aerospace configuration
    ├── atuin/            # Atuin shell history
    ├── ghostty/          # Ghostty terminal
    ├── hammerspoon/      # macOS automation
    ├── karabiner/        # Keyboard customization
    ├── nushell/          # Nushell configuration
    ├── nvim/             # Neovim configuration
    ├── sketchybar/       # macOS menubar
    ├── skhd/             # Simple hotkey daemon
    ├── ssh/              # SSH configuration
    ├── starship/         # Shell prompt
    ├── tmux/             # Terminal multiplexer
    ├── wezterm/          # Terminal emulator
    ├── zellij/           # Terminal workspace
    └── zshrc/            # Zsh configuration
```

## Customization

### For NixOS Users
- Edit files in the `nix/` directory
- Main configuration files:
  - `configuration.nix`: System-wide settings
  - `home-manager.nix`: User-specific configuration
  - `flake.nix`: Dependencies and system configuration

### For Traditional Linux Users
- Configuration files are organized by application in the `dotfiles/` directory
- Edit files directly in their respective directories
- Run `./setup.sh` to apply changes

## Backup
- NixOS configurations are backed up to `~/.config/nixos.backup.<date>`
- Traditional dotfiles are backed up to `~/.config.backup.<date>`

## Pruebas y Verificación

Para asegurarte de que todo funcione correctamente, puedes usar los scripts de prueba incluidos:

1. Verificar requisitos del sistema:
   ```bash
   ./scripts/check-system.sh
   ```

2. Probar la configuración:
   ```bash
   ./scripts/test-config.sh
   ```

Los scripts verificarán:
- Sintaxis y build de configuración NixOS (si aplica)
- Configuración de Stow
- Configuraciones de shell (zsh, tmux)
- Configuración de Neovim
- Y más...

### Solución de Problemas Comunes

#### Para usuarios de NixOS:
1. Si hay errores en el build:
   ```bash
   sudo nixos-rebuild build --show-trace
   ```

2. Para actualizar todos los paquetes:
   ```bash
   nix flake update
   sudo nixos-rebuild switch
   ```

#### Para usuarios de otras distribuciones:
1. Si hay conflictos con Stow:
   ```bash
   stow -D dotfiles  # Desenlazar primero
   stow dotfiles     # Volver a enlazar
   ```

2. Para ver qué archivos se enlazarán:
   ```bash
   stow -nv dotfiles  # Simulación verbose
   ```

## Contributing
Feel free to fork this repository and customize it to your needs. Pull requests are welcome!
