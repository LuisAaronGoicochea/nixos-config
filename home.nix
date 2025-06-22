{ config, pkgs, ... }:

{
  home.stateVersion = "24.05";
  
  home.packages = with pkgs; [
    neovim
    tmux
    fzf
    starship
  ];

  programs.zsh = {
    enable = true;
    enableCompletion = true;
    #ohMyZsh = {
    #  enable = true;
    #  theme = "robbyrussell";
    #  plugins = [ "git" ];
    #};
    shellAliases = {
      ll = "ls -lah";
      update-system = "sudo nixos-rebuild switch --flake /etc/nixos#nixos";
    };
  };

  programs.starship = {
    enable = true;
    enableZshIntegration = true;
  };

  home.file.".config/starship.toml".text = ''
    [character]
    success_symbol = "[➜ ](bold green)"
    error_symbol = "[➜ ](bold red)"
    [username]
    style_user = "bold blue"
    show_always = true
    [hostname]
    style = "bold yellow"
    ssh_only = false
  '';


  programs.git = {
    enable = true;
    userName = "LuisAaronGoicochea";
    userEmail = "luis.aaron18@gmail.com";
  };
}
