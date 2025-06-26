# Core system configuration
{ config, pkgs, ... }:

{
  imports = [ ];

  # Basic system settings
  system.stateVersion = "24.11";
  nixpkgs.config.allowUnfree = true;
  
  # Enable experimental features
  nix.settings.experimental-features = [ "nix-command" "flakes" ];

  # Basic system packages
  environment.systemPackages = with pkgs; [
    # Core utilities
    coreutils
    curl
    wget
    git
    
    # System monitoring
    htop
    btop
    
    # File utilities
    fd
    tree
    ripgrep
    fzf
  ];

  # Default shell configuration
  programs.zsh = {
    enable = true;
    enableCompletion = true;
    autosuggestions.enable = true;
    syntaxHighlighting.enable = true;
  };

  # Default user shell
  users.defaultUserShell = pkgs.zsh;
}
