# NixOS-WSL specific options are documented on the NixOS-WSL repository:
# https://github.com/nix-community/NixOS-WSL

{ config, pkgs, ... }:

{
  nixpkgs.config.allowUnfree = true;

  wsl.enable = true;
  wsl.defaultUser = "nixos";

  system.stateVersion = "24.11";

  environment.systemPackages = with pkgs; [
    # Development
    git
    vim
    neovim
    vscode
    gcc
    gnumake
    python3
    nodejs
    sqlite
    
    # System utilities
    htop
    btop
    curl
    wget
    tree
    fd
    fzf
    bat
    ripgrep
    jq
    yq
    
    # Shell
    zsh
    tmux
    starship
    stow
    
    # Additional tools
    eza # Modern replacement for ls
    delta # Better git diff
    lazygit # Terminal UI for git
    bottom # System monitor
    du-dust # Better du
    procs # Modern replacement for ps
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

  # Home Manager config is handled in flake.nix
}
