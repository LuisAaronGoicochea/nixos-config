{ config, pkgs, dotfiles, ... }:

{
  home.stateVersion = "24.05";

  home.packages = with pkgs; [ neovim tmux starship wezterm zellij nushell ];
  
  programs.zsh.enable = true;
  programs.starship.enable = true;
  
  # ✅ Git setup
  programs.git.enable = true;
  programs.git.userName = "LuisAaronGoicochea";
  programs.git.userEmail = "luis.aaron18@gmail.com";
  programs.git.extraConfig.color.ui = "auto";
  programs.git.extraConfig.init.defaultBranch = "main";

  home.file = if enableDotfiles then {

    # ✅ Home files
    ".zshrc".source                           = config.lib.file.mkOutOfStoreSymlink (dotfiles + "/zshrc/.zshrc");

    # ✅ Nushell
    ".config/nushell/config.nu".source        = config.lib.file.mkOutOfStoreSymlink (dotfiles + "/nushell/config.nu");
    ".config/nushell/env.nu".source           = config.lib.file.mkOutOfStoreSymlink (dotfiles + "/nushell/env.nu");

    # ✅ Starship
    ".config/starship/starship.toml".source   = config.lib.file.mkOutOfStoreSymlink (dotfiles + "/starship/starship.toml");

    # ✅ Tmux
    ".tmux.conf".source                       = config.lib.file.mkOutOfStoreSymlink (dotfiles + "/tmux/tmux.conf");
    home.file.".tmux.reset.conf".source                 = config.lib.file.mkOutOfStoreSymlink (dotfiles + "/tmux/tmux.reset.conf");
    #home.file.".tmux/plugins/tpm".source               = config.lib.file.mkOutOfStoreSymlink (dotfiles + "/tmux/plugins/tpm");

    # ✅ Wezterm
    home.file.".config/wezterm/wezterm.lua".source      = config.lib.file.mkOutOfStoreSymlink (dotfiles + "/wezterm/wezterm.lua");

    # ✅ Hammerspoon
    home.file.".config/hammerspoon/init.lua".source     = config.lib.file.mkOutOfStoreSymlink (dotfiles + "/hammerspoon/init.lua");

    # ✅ Karabiner
    home.file.".config/karabiner/karabiner.json".source = config.lib.file.mkOutOfStoreSymlink (dotfiles + "/karabiner/karabiner.json");

    # ✅ Ghostty
    home.file.".config/ghostty/config".source           = config.lib.file.mkOutOfStoreSymlink (dotfiles + "/ghostty/config");

    # ✅ SSH
    home.file.".config/ssh/ssh-config".source           = config.lib.file.mkOutOfStoreSymlink (dotfiles + "/ssh/ssh-config");

    # ✅ Nvim
    home.file.".config/nvim/init.lua".source            = config.lib.file.mkOutOfStoreSymlink (dotfiles + "/nvim/init.lua");
    home.file.".config/nvim/lazyvim.json".source        = config.lib.file.mkOutOfStoreSymlink (dotfiles + "/nvim/lazyvim.json");
    home.file.".config/nvim/lazy-lock.json".source      = config.lib.file.mkOutOfStoreSymlink (dotfiles + "/nvim/lazy-lock.json");
    home.file.".config/nvim/stylua.toml".source         = config.lib.file.mkOutOfStoreSymlink (dotfiles + "/nvim/stylua.toml");
    home.file.".config/nvim/lua".source                 = config.lib.file.mkOutOfStoreSymlink (dotfiles + "/nvim/lua");

    # ✅ Sketchybar
    home.file.".config/sketchybar/colors.sh".source     = config.lib.file.mkOutOfStoreSymlink (dotfiles + "/sketchybar/colors.sh");
    home.file.".config/sketchybar/icons.sh".source      = config.lib.file.mkOutOfStoreSymlink (dotfiles + "/sketchybar/icons.sh");
    home.file.".config/sketchybar/sketchybarrc".source  = config.lib.file.mkOutOfStoreSymlink (dotfiles + "/sketchybar/sketchybarrc");
    home.file.".config/sketchybar/helper".source        = config.lib.file.mkOutOfStoreSymlink (dotfiles + "/sketchybar/helper");
    home.file.".config/sketchybar/items".source         = config.lib.file.mkOutOfStoreSymlink (dotfiles + "/sketchybar/items");
    home.file.".config/sketchybar/plugins".source       = config.lib.file.mkOutOfStoreSymlink (dotfiles + "/sketchybar/plugins");

    # ✅ SKHD
    home.file.".config/skhd/skhdrc".source              = config.lib.file.mkOutOfStoreSymlink (dotfiles + "/skhd/skhdrc");
    home.file.".config/skhd/applescripts".source        = config.lib.file.mkOutOfStoreSymlink (dotfiles + "/skhd/applescripts");

    # ✅ Zellij
    home.file.".config/zellij/config.kdl".source        = config.lib.file.mkOutOfStoreSymlink (dotfiles + "/zellij/config.kdl");
    home.file.".config/zellij/themes".source            = config.lib.file.mkOutOfStoreSymlink (dotfiles + "/zellij/themes");

    # ✅ Aerospace
    home.file.".config/aerospace/aerospace.toml".source = config.lib.file.mkOutOfStoreSymlink (dotfiles + "/aerospace/aerospace.toml");

    # ✅ Atuin
    home.file.".config/atuin/config.toml".source        = config.lib.file.mkOutOfStoreSymlink (dotfiles + "/atuin/config.toml");

    # ✅ Nix
    home.file.".config/nix/nix.conf".source             = config.lib.file.mkOutOfStoreSymlink (dotfiles + "/nix/nix.conf");

  } else {};
}

