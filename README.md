# NixOS Configuration

This repository contains my NixOS + WSL configuration using Flakes and Home Manager.

## Usage

1. Clone this repo:
   ```bash
   git clone https://github.com/LuisAaronGoicochea/nixos-config
   cd nixos-config```

2. Apply the configuration:
   ```sudo nixos-rebuild switch --flake .#nixos```

3. Update all dependencies:
    ```nix flake update --flake .
    sudo nixos-rebuild switch --flake .#nixos```

## Structure

    flake.nix — Defines inputs and NixOS system.

    configuration.nix — Base system settings.

    home.nix — User's Home Manager configuration.

    flake.lock — Generated lock file for exact versions.
