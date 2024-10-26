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
    autoEnable = false;
    base16Scheme = {
      base00 = "282828";
      base01 = "2f2f2f";
      base02 = "363636";
      base03 = "3c3c3c";
      base04 = "434343";
      base05 = "4a4a4a";
      base06 = "505050"; 
      base07 = "555555";
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
      sansSerif = {
        name = "Hurmit Nerd Font";
        package = pkgs.nerdfonts.override {fonts = ["Hermit"];};
      };
      serif = {
        name = "Hurmit Nerd Font";
        package = pkgs.nerdfonts.override {fonts = ["Hermit"];}; 
      };
      monospace = {
        name = "Hurmit Nerd Font";
        package = pkgs.nerdfonts.override {fonts = ["Hermit"];};
      };
    };
    polarity = "dark";
    targets = {
      spicetify.enable = true;
      gtk.enable = false;
      grub = {
        enable = true;
        useImage = true;
      };
      plymouth.enable = true;
      console.enable = true;
      lightdm.enable = true;
      nixos-icons.enable = true;
    };
  };

  # Extra
  services = {
    flatpak.enable = true;
    printing.enable = true;
  };

  # NixOS Settings
  nix = {
    settings = {
      experimental-features = [ "nix-command" "flakes" ];
      substituters = [ "https://ezkea.cachix.org" ];
      trusted-public-keys = [ "ezkea.cachix.org-1:ioBmUbJTZIKsHmWWXPe1FSFbeVe+afhfgqgTSNd34eI=" ];
    };
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
      enable = false;
    };
  };

  # Network, Locales & Loaction  

  networking = {
    hostName = "nixos";
    networkmanager.enable = true;
  };

  time.timeZone = "Europe/Athens";

  i18n = {
    defaultLocale = "en_GB.UTF-8";
    extraLocaleSettings = {
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
  };
  # Wayland, X11, Keyboards, Keymaps, Display Managers & Desktop Environments  
  services = {
    desktopManager = {
      plasma6.enable = true;
    };
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
    sudo = {
      enable = true;
      wheelNeedsPassword = false;
    };
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
      legcord
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
       audacity
       pinta
       cava
       heroic
       neothesia
       viber
       prismlauncher
       discordo
       cmatrix
       libnotify
       hyprpaper
       rofi-wayland
       spicetify-cli
       stremio
#       xfce.thunar
#       xfce.thunar-volman
       dunst
       yazi
       wineWow64Packages.waylandFull
       btop
       obs-studio
       whatsapp-for-linux     
     ];
     sessionVariables = {
       WLR_NO_HARDWARE_CURSORS = "1";
       NIXOS_OZONE_WL = "1";
     };
  };
  
  # Hardware
  hardware = {
    graphics.enable = true;
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
