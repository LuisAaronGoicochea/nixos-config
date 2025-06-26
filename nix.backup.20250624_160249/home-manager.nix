{ config, pkgs, lib, dotfiles, enableDotfiles ? true, ... }:

{
  home.stateVersion = "24.05";

  home.packages = with pkgs; [ neovim tmux starship wezterm zellij nushell stow ];
  
  programs.zsh.enable = true;
  programs.starship.enable = true;
  
  # ✅ Git setup
  programs.git = {
    enable = true;
    userName = "LuisAaronGoicochea";
    userEmail = "luis.aaron18@gmail.com";
    
    extraConfig = {
      color.ui = "auto";
      init.defaultBranch = "main";
      pull.rebase = true;
      push.autoSetupRemote = true;
      core = {
        editor = "nvim";
        whitespace = "trailing-space,space-before-tab";
      };
      diff.colorMoved = "default";
      merge.conflictStyle = "diff3";
    };

    delta = {
      enable = true;
      options = {
        navigate = true;
        line-numbers = true;
        syntax-theme = "GitHub";
      };
    };
  };

  home.activation.stowDotfiles = lib.hm.dag.entryAfter [ "writeBoundary" ] ''
    ${pkgs.stow}/bin/stow --version
    ${pkgs.stow}/bin/stow --dir=${dotfiles} --target=$HOME --delete --verbose *
    ${pkgs.stow}/bin/stow --dir=${dotfiles} --target=$HOME --restow --verbose *
  '';

}

