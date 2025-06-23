{ config, pkgs, dotfilesAbsPath, enableDotfiles, ... }:

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
    ".zshrc".source                                     = config.lib.file.mkOutOfStoreSymlink "${dotfilesAbsPath}/zshrc/.zshrc";

    # ✅ Nushell
    ".config/nushell/config.nu".source                  = config.lib.file.mkOutOfStoreSymlink "${dotfilesAbsPath}/nushell/config.nu";
    ".config/nushell/env.nu".source                     = config.lib.file.mkOutOfStoreSymlink "${dotfilesAbsPath}/nushell/env.nu");

    # ✅ Starship
    ".config/starship/starship.toml".source             = config.lib.file.mkOutOfStoreSymlink "${dotfilesAbsPath}/starship/starship.toml";

    # ✅ Tmux
    ".tmux.conf".source                                 = config.lib.file.mkOutOfStoreSymlink "${dotfilesAbsPath}/tmux/tmux.conf";
    home.file.".tmux.reset.conf".source                 = config.lib.file.mkOutOfStoreSymlink "${dotfilesAbsPath}tmux/tmux.reset.conf";

    # ✅ Wezterm
    home.file.".config/wezterm/wezterm.lua".source      = config.lib.file.mkOutOfStoreSymlink "${dotfilesAbsPath}/wezterm/wezterm.lua";

    # ✅ Hammerspoon
    home.file.".config/hammerspoon/init.lua".source     = config.lib.file.mkOutOfStoreSymlink "${dotfilesAbsPath}/hammerspoon/init.lua";

    # ✅ Karabiner
    home.file.".config/karabiner/karabiner.json".source = config.lib.file.mkOutOfStoreSymlink "${dotfilesAbsPath}/karabiner/karabiner.json";

    # ✅ Ghostty
    home.file.".config/ghostty/config".source           = config.lib.file.mkOutOfStoreSymlink "${dotfilesAbsPath}/ghostty/config";

    # ✅ SSH
    home.file.".config/ssh/ssh-config".source           = config.lib.file.mkOutOfStoreSymlink "${dotfilesAbsPath}/ssh/ssh-config";

    # ✅ Nvim
    home.file.".config/nvim/init.lua".source            = config.lib.file.mkOutOfStoreSymlink "${dotfilesAbsPath}/nvim/init.lua";
    home.file.".config/nvim/lazyvim.json".source        = config.lib.file.mkOutOfStoreSymlink "${dotfilesAbsPath}/nvim/lazyvim.json";
    home.file.".config/nvim/lazy-lock.json".source      = config.lib.file.mkOutOfStoreSymlink "${dotfilesAbsPath}/nvim/lazy-lock.json";
    home.file.".config/nvim/stylua.toml".source         = config.lib.file.mkOutOfStoreSymlink "${dotfilesAbsPath}/nvim/stylua.toml";
    home.file.".config/nvim/lua".source                 = config.lib.file.mkOutOfStoreSymlink "${dotfilesAbsPath}/nvim/lua";

    # ✅ Sketchybar
    home.file.".config/sketchybar/colors.sh".source     = config.lib.file.mkOutOfStoreSymlink "${dotfilesAbsPath}/sketchybar/colors.sh";
    home.file.".config/sketchybar/icons.sh".source      = config.lib.file.mkOutOfStoreSymlink "${dotfilesAbsPath}/sketchybar/icons.sh";
    home.file.".config/sketchybar/sketchybarrc".source  = config.lib.file.mkOutOfStoreSymlink "${dotfilesAbsPath}/sketchybar/sketchybarrc";
    home.file.".config/sketchybar/helper".source        = config.lib.file.mkOutOfStoreSymlink "${dotfilesAbsPath}/sketchybar/helper";
    home.file.".config/sketchybar/items".source         = config.lib.file.mkOutOfStoreSymlink "${dotfilesAbsPath}/sketchybar/items";
    home.file.".config/sketchybar/plugins".source       = config.lib.file.mkOutOfStoreSymlink "${dotfilesAbsPath}/sketchybar/plugins";

    # ✅ SKHD
    home.file.".config/skhd/skhdrc".source              = config.lib.file.mkOutOfStoreSymlink "${dotfilesAbsPath}/skhd/skhdrc";
    home.file.".config/skhd/applescripts".source        = config.lib.file.mkOutOfStoreSymlink "${dotfilesAbsPath}/skhd/applescripts";

    # ✅ Zellij
    home.file.".config/zellij/config.kdl".source        = config.lib.file.mkOutOfStoreSymlink "${dotfilesAbsPath}/zellij/config.kdl";
    home.file.".config/zellij/themes".source            = config.lib.file.mkOutOfStoreSymlink "${dotfilesAbsPath}/zellij/themes";

    # ✅ Aerospace
    home.file.".config/aerospace/aerospace.toml".source = config.lib.file.mkOutOfStoreSymlink "${dotfilesAbsPath}/aerospace/aerospace.toml";

    # ✅ Atuin
    home.file.".config/atuin/config.toml".source        = config.lib.file.mkOutOfStoreSymlink "${dotfilesAbsPath}/atuin/config.toml";

    # ✅ Nix
    home.file.".config/nix/nix.conf".source             = config.lib.file.mkOutOfStoreSymlink "${dotfilesAbsPath}/nix/nix.conf";

  } else {};
}

