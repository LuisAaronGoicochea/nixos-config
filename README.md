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

1. Install GNU Stow and other dependencies:

##### Ubuntu/Debian
```bash
sudo apt update
sudo apt install stow git zsh tmux neovim fzf ripgrep bat fd-find
# Install starship
curl -sS https://starship.rs/install.sh | sh
```

##### Fedora
```bash
sudo dnf install stow git zsh tmux neovim fzf ripgrep bat fd-find
# Install starship
curl -sS https://starship.rs/install.sh | sh
```

##### Arch Linux
```bash
sudo pacman -S stow git zsh tmux neovim fzf ripgrep bat fd
# Install starship
curl -sS https://starship.rs/install.sh | sh
```

#### Installation Steps

1. Clone the repository:
```bash
git clone https://github.com/LuisAaronGoicochea/nixos-config ~/.dotfiles
cd ~/.dotfiles
```

2. Run the setup script:
```bash
./setup.sh
```

The script will:
- Backup your existing configurations
- Install all dotfiles using stow
- Show you where your backups are stored

#### Post-Installation

1. Change your default shell to zsh:
```bash
chsh -s $(which zsh)
```

2. Start a new terminal session to see the changes

#### Customization

You can customize the installation by:

1. **Selective Installation**: Edit the `STOW_DIRS` array in `setup.sh`
2. **Configuration Changes**: Edit files in their respective directories
3. **Adding New Tools**: Create new directories and add to `STOW_DIRS`
```````
This is the description of what the code block changes:
<changeDescription>
Fixing typos and improving clarity in the documentation
</changeDescription>

This is the code block that represents the suggested code change:
````markdown
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

1. Install GNU Stow and other dependencies:

##### Ubuntu/Debian
```bash
sudo apt update
sudo apt install stow git zsh tmux neovim fzf ripgrep bat fd-find
# Install starship
curl -sS https://starship.rs/install.sh | sh
```

##### Fedora
```bash
sudo dnf install stow git zsh tmux neovim fzf ripgrep bat fd-find
# Install starship
curl -sS https://starship.rs/install.sh | sh
```

##### Arch Linux
```bash
sudo pacman -S stow git zsh tmux neovim fzf ripgrep bat fd
# Install starship
curl -sS https://starship.rs/install.sh | sh
```

#### Installation Steps

1. Clone the repository:
```bash
git clone https://github.com/LuisAaronGoicochea/nixos-config ~/.dotfiles
cd ~/.dotfiles
```

2. Run the setup script:
```bash
./setup.sh
```

The script will:
- Backup your existing configurations
- Install all dotfiles using stow
- Show you where your backups are stored

#### Post-Installation

1. Change your default shell to zsh:
```bash
chsh -s $(which zsh)
```

2. Start a new terminal session to see the changes

#### Customization

You can customize the installation by:

1. **Selective Installation**: Edit the `STOW_DIRS` array in `setup.sh`
2. **Configuration Changes**: Edit files in their respective directories
3. **Adding New Tools**: Create new directories and add to `STOW_DIRS`
```````
