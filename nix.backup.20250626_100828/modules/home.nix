# Home Manager configuration
{ config, pkgs, lib, dotfiles, username, ... }:

{
  # Home Manager needs a bit of information about you and the paths it should manage
  home = {
    username = username;
    homeDirectory = "/home/${username}";
    stateVersion = "24.05";

    # Packages to install
    packages = with pkgs; [
      # Development
      neovim
      git
      tmux
      
      # Shell utilities
      fzf
      ripgrep
      bat
      eza
      fd
      
      # System monitoring
      htop
      btop
      
      # Other tools
      starship
    ];
  };

  # Enable programs
  programs = {
    home-manager.enable = true;

    # Git configuration
    git = {
      enable = true;
      userName = "LuisAaronGoicochea";
      userEmail = "luis.aaron18@gmail.com";
      extraConfig = {
        init.defaultBranch = "main";
        pull.rebase = true;
        core.editor = "nvim";
      };
    };

    # Starship prompt
    starship = {
      enable = true;
      enableBashIntegration = false;
      enableZshIntegration = true;
    };

    # Zsh configuration
    zsh = {
      enable = true;
      enableAutosuggestions = true;
      enableSyntaxHighlighting = true;
      oh-my-zsh = {
        enable = true;
        theme = "robbyrussell";
        plugins = [ "git" "docker" "npm" "pip" ];
      };
    };
  };
}
