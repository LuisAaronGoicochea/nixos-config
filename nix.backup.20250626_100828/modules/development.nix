# Development tools configuration
{ config, pkgs, ... }:

{
  environment.systemPackages = with pkgs; [
    # Editors
    neovim
    vscode

    # Development tools
    gcc
    gnumake
    cmake
    ninja
    
    # Languages
    python3
    nodejs
    go
    rustc
    cargo

    # Development utilities
    git-lfs
    lazygit
    gh  # GitHub CLI
    
    # Docker
    docker
    docker-compose
  ];

  # Enable Docker
  virtualisation.docker.enable = true;

  # Python development
  programs.python = {
    enable = true;
    package = pkgs.python3;
    enableBashIntegration = true;
  };

  # Node.js development
  programs.npm = {
    enable = true;
    npmrc = '''';
  };
}
