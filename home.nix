{ config, pkgs, ... }:

let
  df = ./dotfiles;
in {
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

  # Integración con los dotfiles clonados
  home.file.".zshrc".source = df + "/zshrc/.zshrc";
  home.file.".tmux.conf".source = df + "/tmux/.tmux.conf";
  home.file.".config/nvim/init.lua".source = df + "/nvim/init.lua";
  home.file.".config/nvim/lua".source = df + "/nvim/lua";
  home.file.".config/starship.toml".source = df + "/starship/starship.toml";
  home.file.".ssh/config".source = df + "/ssh/config";

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
