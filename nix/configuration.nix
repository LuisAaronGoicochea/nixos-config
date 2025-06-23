# NixOS-WSL specific options are documented on the NixOS-WSL repository:
# https://github.com/nix-community/NixOS-WSL

{ config, pkgs, ... }:

{
  wsl.enable = true;
  wsl.defaultUser = "nixos";

  system.stateVersion = "24.11";

  environment.systemPackages = with pkgs; [
    git
    vim
    htop
    curl
    wget
    zsh
    python3
    sqlite
    nodejs
    tmux
    fzf
    bat
    ripgrep
    stow
    gcc
    tree
    vscode
  ];
  
  programs.zsh.enable = true;
  
  programs.nix-ld = {
    enable = true;
    package = pkgs.nix-ld-rs;
  };

  
  users.defaultUserShell = pkgs.zsh;
 
  nix.settings.experimental-features = [ "nix-command" "flakes" ];

  home-manager.useGlobalPkgs = true;
  home-manager.useUserPackages = true;
  home-manager.backupFileExtension = "off";

  # Home Manager config will live in home.nix
  home-manager.users.nixos = import ./home-manager.nix;
}
