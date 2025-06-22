{
  description = "NixOS-WSL + Home Manager with Flakes";

  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs/nixos-unstable";
    nixos-wsl.url = "github:nix-community/NixOS-WSL/main";
    home-manager.url = "github:nix-community/home-manager";
    home-manager.inputs.nixpkgs.follows = "nixpkgs";
  };

  outputs = { self, nixpkgs, nixos-wsl, home-manager, ... }:
    let
      system = "x86_64-linux";
    in {
      nixosConfigurations.nixos = nixpkgs.lib.nixosSystem {
        inherit system;

        specialArgs = {
          dotfiles = ./dotfiles;
        };
        modules = [
          nixos-wsl.nixosModules.default

          # Esta es la parte clave: el módulo NixOS de Home Manager
          home-manager.nixosModules.home-manager

          # Tu configuración del sistema
          ./configuration.nix

          # Tu configuración Home Manager
          {
            home-manager.useGlobalPkgs = true;
            home-manager.useUserPackages = true;

            home-manager.users.nixos = import ./home-manager.nix;
          }
        ];
      };
    };
}

