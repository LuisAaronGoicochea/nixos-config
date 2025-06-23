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
      dotfiles = ../dotfiles;
      enableDotfilesInHomeManager = false;
    in {
      nixosConfigurations.nixos = nixpkgs.lib.nixosSystem {
        inherit system;
        specialArgs = { dotfiles = dotfiles; };
        modules = [
          nixos-wsl.nixosModules.default
          home-manager.nixosModules.home-manager
          ./configuration.nix
          {
            home-manager.useGlobalPkgs = true;
            home-manager.useUserPackages = true;
            home-manager.extraSpecialArgs = { dotfiles = dotfiles; enableDotfiles = enableDotfilesInHomeManager; };
            home-manager.users.nixos = import ./home-manager.nix;
          }
        ];
      };
    };
}

