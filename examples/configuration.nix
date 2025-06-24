# Example configuration for your system
# Copy this file to your preferred location and modify as needed

{
  # Basic system configuration
  system = "x86_64-linux";    # Your system architecture
  hostname = "my-nixos";      # Your desired hostname
  username = "myuser";        # Your username
  stateVersion = "24.05";     # NixOS version
  
  # Additional modules you want to include
  extraModules = [
    ./custom-modules/gaming.nix
    ./custom-modules/development.nix
  ];
  
  # Optional: specify a custom config directory
  # configDir = "/path/to/your/config";
  
  # Enable/disable features
  features = {
    gui = true;           # Enable GUI applications
    dev = true;           # Development tools
    gaming = false;       # Gaming related packages
    virtualisation = true; # Docker, QEMU, etc.
  };
  
  # Custom packages to install
  extraPackages = pkgs: with pkgs; [
    firefox
    vscode
    spotify
  ];
}
