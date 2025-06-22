{ config, pkgs, dotfiles, ... }:

{
  home.stateVersion = "24.05";
  home.packages = with pkgs; [ neovim tmux starship ];
  programs.zsh.enable = true;
  programs.starship.enable = true;

  home.file.".zshrc".source = dotfiles + "/zshrc";
  home.file.".tmux.conf".source = dotfiles + "/tmux/.tmux.conf";
  home.file.".config/nvim/init.lua".source = dotfiles + "/nvim/init.lua";
  home.file.".config/nvim/lua".source = dotfiles + "/nvim/lua";
  home.file.".config/starship.toml".source = dotfiles + "/starship/starship.toml";

  programs.git.enable = true;
  programs.git.userName = "LuisAaronGoicochea";
  programs.git.userEmail = "luis.aaron18@gmail.com";
  programs.git.extraConfig.color.ui = "auto";
  programs.git.extraConfig.init.defaultBranch = "main";
}

