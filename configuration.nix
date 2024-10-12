# Antam's NixOS Configuration.nix File

{ config, pkgs, inputs, ... }:

{
  # Programs
  programs = {
    nh.enable = true;
    fish.enable = true;
    hyprland = {
      enable = true;
      xwayland.enable = true;
    };

    steam = {
      enable = true;
      remotePlay.openFirewall = true;
      dedicatedServer.openFirewall = true;
      localNetworkGameTransfers.openFirewall = true;
    };
  };

  # Stylix
  stylix = {
    enable = true;
    base16Scheme = {
      base00 = "282828";
      base01 = "ed787e";
      base02 = "f08f94";
      base03 = "f3a5a9";
      base04 = "f6b9bc";
      base05 = "f9d2d4";
      base06 = "fce8e9"; 
      base07 = "ffffff";
      base08 = "ea6269";
      base09 = "ed787e";
      base0A = "f08f94";
      base0B = "f3a5a9";
      base0C = "f6b9bc";
      base0D = "f9d2d4";
      base0E = "fce8e9";
      base0F = "ffffff";
    };
    image = /home/antam/Pictures/yae_miko.png;
#    cursor = {
#      name = "Qogir Cursors";
#      package = "Qogir-icon-theme";
#    };
    fonts = {
#      sansSerif = {
#        name = "Purisa";
#        package = pkgs.purisa-font;
#      };
#      serif = { 
#        name = "Purisa";
#        package = pkgs.purisa-font;
#      };
      monospace = {
        name = "JetBrainsMono Nerd Font Mono";
        package = pkgs.nerdfonts.override {fonts = ["JetBrainsMono"];};
      };
    };
    polarity = "dark";
    targets = {
      spicetify.enable = true;
      gtk.enable = false;
    };
  };

  # Extra
  services.flatpak.enable = true;
  services.printing.enable = true;

  # NixOS Settings
  nix.settings = {
    experimental-features = [ "nix-command" "flakes" ];
    substituters = [ "https://ezkea.cachix.org" ];
    trusted-public-keys = [ "ezkea.cachix.org-1:ioBmUbJTZIKsHmWWXPe1FSFbeVe+afhfgqgTSNd34eI=" ];
  };

  # Imports
  imports =
    [  
      ./hardware-configuration.nix
      inputs.home-manager.nixosModules.default
    ];

  # Booting
  boot = {
    loader = {
      efi.canTouchEfiVariables = true;
      grub = {
        enable = true;
        devices = [ "nodev" ];
        efiSupport = true;
        useOSProber = true;
      };
    };
    
    plymouth = {
      enable = true;
    };
  };

  # Network, Locales & Loaction  

  networking.hostName = "nixos"; # Define your hostname.
  networking.networkmanager.enable = true;

  time.timeZone = "Europe/Athens";

  i18n.defaultLocale = "en_GB.UTF-8";
  i18n.extraLocaleSettings = {
    LC_ADDRESS = "el_GR.UTF-8";
    LC_IDENTIFICATION = "el_GR.UTF-8";
    LC_MEASUREMENT = "el_GR.UTF-8";
    LC_MONETARY = "el_GR.UTF-8";
    LC_NAME = "el_GR.UTF-8";
    LC_NUMERIC = "el_GR.UTF-8";
    LC_PAPER = "el_GR.UTF-8";
    LC_TELEPHONE = "el_GR.UTF-8";
    LC_TIME = "el_GR.UTF-8";
  };

  # Wayland, X11, Keyboards, Keymaps, Display Managers & Desktop Environments  
  services = {
    desktopManager.plasma6.enable = true;
    xserver = {
      enable = true;
      xkb = {
        layout = "gb";
        variant = "";
      };
      displayManager = {
        lightdm = {
          enable = true;
          greeters.slick.enable = true;
        };
      };
    };
  };
  console.keyMap = "uk";

  # Desktop Portals
  xdg = {
    portal = {
      enable = true;
      extraPortals = [ pkgs.xdg-desktop-portal-gtk ];
    };
  };

  # Audio & Sudo
  security = {
    rtkit.enable = true;
    sudo.enable = true;
    sudo.wheelNeedsPassword = false;
  };
  services.pipewire = {
    enable = true;
    alsa.enable = true;
    alsa.support32Bit = true;
    pulse.enable = true;
    jack.enable = true;
  };  

  # User, Apps & General Settings
  users.users.antam = {
    isNormalUser = true;
    description = "Antam";
    extraGroups = [ "networkmanager" "wheel" ];
    packages = with pkgs; [
      neofetch
      armcord
      kdePackages.kate
            
    ];
   shell = pkgs.fish;
  };

  nixpkgs.config.permittedInsecurePackages = [
    "openssl-1.1.1w"
  ];


  nixpkgs.config.allowUnfree = true;

  # Environment
  environment = {
     systemPackages = with pkgs; [
       brave
       kitty
       vscode
       audacity
       pinta
       cava
       xfce.thunar
       xfce.thunar-volman
       heroic
       neothesia
       viber
       prismlauncher
       discordo
       cmatrix
       dunst
       libnotify
       hyprpaper
       swaybg
       wpaperd
       mpvpaper
       swww
       rofi-wayland
       spicetify-cli
              
       (waybar.overrideAttrs (oldAttrs: {
          mesonFlags = oldAttrs.mesonFlags ++ [ "-Dexperimental=true" ];
         })
       )
     ];
     sessionVariables = {
       WLR_NO_HARDWARE_CURSORS = "1";
       NIXOS_OZONE_WL = "1";
     };
  };
  
  # Hardware
  hardware = {
    opengl.enable = true;
    nvidia.modesetting.enable = true;
  };

  # Home Manager
  home-manager = {
    extraSpecialArgs = { inherit inputs; };
    users = {
      "antam" = import ./home.nix;
    };
  };

  # System Version
  system.stateVersion = "24.05";

}
