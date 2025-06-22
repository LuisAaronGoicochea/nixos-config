{ config, pkgs, dotfiles, ... }:

{
  home.stateVersion = "24.05";

  home.packages = with pkgs; [ neovim tmux starship ];

  programs.zsh = {
    enable = true;
    enableCompletion = true;
  };

  programs.starship = {
    enable = true;
    enableZshIntegration = true;
  };

  home.file.".zshrc".source = dotfiles + "/zshrc";
  home.file.".tmux.conf".source = dotfiles + "/tmux/.tmux.conf";
  home.file.".config/nvim/init.lua".source = dotfiles + "/nvim/init.lua";
  home.file.".config/nvim/lua".source = dotfiles + "/nvim/lua";
  home.file.".config/starship.toml".source = dotfiles + "/starship/starship.toml";

  programs.git = {
    enable = true;
    userName = "LuisAaronGoicochea";
    userEmail = "luis.aaron18@gmail.com";
    extraConfig = {
      color.ui = "auto";
      init.defaultBranch = "main";
    };
  };
}

