{ config, pkgs, dotfiles, enableDotfiles ? true, ... }:

{
  home.stateVersion = "24.05";

  home.packages = with pkgs; [ neovim tmux starship wezterm zellij nushell stow ];
  
  programs.zsh.enable = true;
  programs.starship.enable = true;
  
  # ✅ Git setup
  programs.git.enable = true;
  programs.git.userName = "LuisAaronGoicochea";
  programs.git.userEmail = "luis.aaron18@gmail.com";
  programs.git.extraConfig.color.ui = "auto";
  programs.git.extraConfig.init.defaultBranch = "main";

  home.activation.stowDotfiles = lib.hm.dag.entryAfter [ "writeBoundary" ] ''
    echo "👉 Running stow to symlink dotfiles into $HOME..."

    # Te aseguras que stow esté en PATH
    ${pkgs.stow}/bin/stow --version

    # Elimina symlinks antiguos que pueden estar en conflicto
    ${pkgs.stow}/bin/stow --dir=${dotfiles} --target=$HOME --delete --verbose *

    # Restaura nuevos symlinks automáticamente
    ${pkgs.stow}/bin/stow --dir=${dotfiles} --target=$HOME --restow --verbose *
  '';

}

