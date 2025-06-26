{
  description = "Universal Dotfiles with NixOS/Home-Manager and Stow support";

  inputs = {
    # Nixpkgs
    nixpkgs.url = "github:NixOS/nixpkgs/nixos-unstable";
    nixpkgs-unstable.url = "github:NixOS/nixpkgs/nixos-unstable";
    
    # Home manager
    home-manager = {
      url = "github:nix-community/home-manager";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    
    # Additional inputs
    nixos-wsl.url = "github:nix-community/NixOS-WSL/main";
    flake-utils.url = "github:numtide/flake-utils";
    
    # Optional: Darwin support
    darwin = {
      url = "github:lnl7/nix-darwin/master";
      inputs.nixpkgs.follows = "nixpkgs";
    };
  };

  outputs = { self, nixpkgs, nixpkgs-unstable, home-manager, flake-utils, nixos-wsl, darwin, ... }:
    let
      system = "x86_64-linux";
      username = "nixos";
      hostname = "nixos";
      stateVersion = "24.05";
    in
    {
      nixosConfigurations.${hostname} = nixpkgs.lib.nixosSystem {
        inherit system;
        
        specialArgs = { 
          inherit username hostname stateVersion;
        };
        
        modules = [
          (./. + "/modules/core.nix")
          (./. + "/modules/users.nix")
          nixos-wsl.nixosModules.default
          ./configuration.nix
          home-manager.nixosModules.home-manager
          {
            home-manager = {
              useGlobalPkgs = true;
              useUserPackages = true;
              extraSpecialArgs = {
                inherit username;
              };
              users.${username} = import (./. + "/modules/home.nix");
            };
          }
        ];
      };

      homeConfigurations.${username} = home-manager.lib.homeManagerConfiguration {
        pkgs = nixpkgs.legacyPackages.${system};
        extraSpecialArgs = {
          inherit username;
        };
        modules = [
          (./. + "/modules/home.nix")
        ];
      };
    };
}

