{ config, pkgs, ... }:

{
  home.stateVersion = "24.11"; # OK ahora que usamos flakes
  programs.zsh.enable = true;

  home.packages = with pkgs; [
    neovim
    tmux
    fzf
  ];

  programs.git = {
    enable = true;
    userName = "LuisAaronGoicochea";
    userEmail = "luis.aaron18@gmail.com";
  };
}
