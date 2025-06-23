{ config, pkgs, dotfiles, ... }:

{
  home.stateVersion = "24.05";
  home.packages = with pkgs; [ neovim tmux starship ];
  
  programs.zsh.enable = true;
  programs.starship.enable = true;

  # ✅ Git setup
  programs.git.enable = true;
  programs.git.userName = "LuisAaronGoicochea";
  programs.git.userEmail = "luis.aaron18@gmail.com";
  programs.git.extraConfig.color.ui = "auto";
  programs.git.extraConfig.init.defaultBranch = "main";

  # ✅ Home files
  home.file.".zshrc".source = dotfiles + "/zshrc/.zshrc";

  # ✅ Nushell
  home.file.".config/nushell/config.nu".source = dotfiles + "/nushell/config.nu";
  home.file.".config/nushell/env.nu".source    = dotfiles + "/nushell/env.nu";

  # ✅ Starship
  home.file.".config/starship/starship.toml".source = dotfiles + "/starship/starship.toml";

  # ✅ Tmux
  home.file.".tmux.conf".source             = dotfiles + "/tmux/tmux.conf";
  home.file.".tmux.reset.conf".source       = dotfiles + "/tmux/tmux.reset.conf";
  #home.file.".tmux/plugins/tpm".source      = dotfiles + "/tmux/plugins/tpm";

  # ✅ Wezterm
  home.file.".config/wezterm/wezterm.lua".source = dotfiles + "/wezterm/wezterm.lua";

  # ✅ Hammerspoon
  home.file.".config/hammerspoon/init.lua".source = dotfiles + "/hammerspoon/init.lua";

  # ✅ Karabiner
  home.file.".config/karabiner/karabiner.json".source = dotfiles + "/karabiner/karabiner.json";

  # ✅ Ghostty
  home.file.".config/ghostty/config".source = dotfiles + "/ghostty/config";

  # ✅ SSH
  home.file.".config/ssh/ssh-config".source = dotfiles + "/ssh/ssh-config";

  # ✅ Nvim
  home.file.".config/nvim/init.lua".source      = dotfiles + "/nvim/init.lua";
  home.file.".config/nvim/lazyvim.json".source  = dotfiles + "/nvim/lazyvim.json";
  home.file.".config/nvim/lazy-lock.json".source= dotfiles + "/nvim/lazy-lock.json";
  home.file.".config/nvim/stylua.toml".source  = dotfiles + "/nvim/stylua.toml";
  home.file.".config/nvim/lua".source          = dotfiles + "/nvim/lua";

  # ✅ Sketchybar
  home.file.".config/sketchybar/colors.sh".source    = dotfiles + "/sketchybar/colors.sh";
  home.file.".config/sketchybar/icons.sh".source     = dotfiles + "/sketchybar/icons.sh";
  home.file.".config/sketchybar/sketchybarrc".source = dotfiles + "/sketchybar/sketchybarrc";
  home.file.".config/sketchybar/helper".source       = dotfiles + "/sketchybar/helper";
  home.file.".config/sketchybar/items".source        = dotfiles + "/sketchybar/items";
  home.file.".config/sketchybar/plugins".source      = dotfiles + "/sketchybar/plugins";

  # ✅ SKHD
  home.file.".config/skhd/skhdrc".source      = dotfiles + "/skhd/skhdrc";
  home.file.".config/skhd/applescripts".source= dotfiles + "/skhd/applescripts";

  # ✅ Zellij
  home.file.".config/zellij/config.kdl".source = dotfiles + "/zellij/config.kdl";
  home.file.".config/zellij/themes".source     = dotfiles + "/zellij/themes";

  # ✅ Aerospace
  home.file.".config/aerospace/aerospace.toml".source = dotfiles + "/aerospace/aerospace.toml";

  # ✅ Atuin
  home.file.".config/atuin/config.toml".source = dotfiles + "/atuin/config.toml";

  # ✅ Nix
  home.file.".config/nix/nix.conf".source = dotfiles + "/nix/nix.conf";
}

