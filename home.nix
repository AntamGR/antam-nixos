{ config, pkgs, ... }:

{
  
  home.username = "antam";
  home.homeDirectory = "/home/antam";

  home.stateVersion = "24.05";

  home.packages = [
    
  ];

  home.file = {
    
  };

  home.sessionVariables = {
#    EDITOR = "kate";
  };

  # Stylix
  stylix = {
    targets = {
      spicetify.enable = true;
    };
  };

  programs.home-manager.enable = true;
}
