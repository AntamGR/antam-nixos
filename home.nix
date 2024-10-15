{ config, pkgs, ... }:

{
  # Home  
  home = {
    username = "antam";
    homeDirectory = "/home/antam";
    stateVersion = "24.05";
    packages = [
    
    ];
    file = {
    
    };
    sessionVariables = {
      EDITOR = "kate";
    };
  };
 
  # Extra 
#  services  = { };

  # Stylix
  stylix = {
    enable = true;
    targets = {
      spicetify.enable = true;
      kitty.enable = false;
    };
  };
  
  # Apps
  programs = {
    home-manager.enable = true;
    waybar = {
      systemd = {
        enable = true;
        target = "hyprland-session.target";
      };
    };
  };
}
