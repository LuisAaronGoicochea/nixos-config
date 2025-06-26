# Module for user configuration
{ config, pkgs, lib, username, ... }:

{
  options = {
    primaryUser = lib.mkOption {
      type = lib.types.str;
      default = username;
      description = "The primary user of the system";
    };
  };

  config = {
    # Create the user
    users.users.${config.primaryUser} = {
      isNormalUser = true;
      extraGroups = [ "wheel" "networkmanager" "docker" ];
      shell = pkgs.zsh;
      initialPassword = "changeme";
    };

    # Enable sudo for the user
    security.sudo.wheelNeedsPassword = false;
  };
}
