# Shell tools and terminal configuration
{ config, pkgs, ... }:

{
  environment.systemPackages = with pkgs; [
    # Shell utilities
    zsh
    tmux
    starship
    zellij
    
    # Modern CLI tools
    exa # Modern ls
    bat # Modern cat
    fd # Modern find
    bottom # Modern top
    du-dust # Modern du
    procs # Modern ps
    delta # Better git diff
    
    # Additional tools
    fzf # Fuzzy finder
    jq # JSON processor
    yq # YAML processor
    htop # Process viewer
    neofetch # System info
  ];

  # Starship prompt
  programs.starship = {
    enable = true;
    enableZshIntegration = true;
  };

  # Zsh configuration
  programs.zsh = {
    enable = true;
    autosuggestions.enable = true;
    syntaxHighlighting.enable = true;
  };
}
