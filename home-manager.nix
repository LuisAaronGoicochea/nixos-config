{ config, pkgs, dotfiles, ... }:

{
  home.stateVersion = "24.05";
  home.packages = with pkgs; [ neovim tmux starship ];
  programs.zsh.enable = true;
  programs.starship.enable = true;
  
  home.file.".tmux.conf".source = dotfiles + "/tmux/tmux.conf";

  programs.git.enable = true;
  programs.git.userName = "LuisAaronGoicochea";
  programs.git.userEmail = "luis.aaron18@gmail.com";
  programs.git.extraConfig.color.ui = "auto";
  programs.git.extraConfig.init.defaultBranch = "main";
}

