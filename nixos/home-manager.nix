{
  config,
  pkgs,
  inputs,
   ...
}: let

in {
  imports = [
   /*  inputs.nixvim.homeManagerModules.nixvim */
 /* inputs.nixvim.homeManagerModules.nixvim */
    /*  ./nixvim.nix  */ 
  ];

  home-manager.users.coco = {
    /*
    The home.stateVersion option does not have a default and must be set
    */
    home.stateVersion = "23.11";
    /*
    Here goes the rest of your home-manager config, e.g. home.packages = [ pkgs.foo ];
    */

    home.packages = [
      pkgs.atool
      pkgs.httpie
      pkgs.cinnamon.nemo
      pkgs.black
      pkgs.brave
      pkgs.dex
      pkgs.firefox
      pkgs.foot
      pkgs.gedit
      pkgs.superTuxKart
      pkgs.swww
      pkgs.swaynotificationcenter
      pkgs.yazi
    ];

    programs.git = {
      enable = true;
      userName = "sachinchaudhary1808";
      userEmail = "chaudharysachinasachin@gmail.com";
    };

    programs.bash = {
      enable = true;
      enableCompletion = true;

      initExtra = ''
              nitch
        #      if [ -f $HOME/.bashrc-personal ]; then
         #       source $HOME/.bashrc-personal
          #    fi
      '';

      shellAliases = {
        nixupdate = "sudo nixos-rebuild switch";
        nixgen = "sudo nix-env -p /nix/var/nix/profiles/system --list-generations";
        ne = "nix-env";
        ni = "nix-env -iA";
        no = "nixops";
        ns = "nix-shell -p";
        v = "nvim";
        sv = "sudo nvim";
      };
    };

    programs = {
      starship = {
        enable = true;
        enableBashIntegration = true;
        enableFishIntegration = true;
      };
    };

    gtk = {
      enable = true; # Enable GTK theme management
      theme = {
        # Choose your theme name and package
        name = "Catppuccin-Mocha-Compact-Blue-Dark";
        package = pkgs.catppuccin-gtk.override {
          accents = ["blue"];
          variant = "mocha";
          size = "compact";
        };
      };
    };

    gtk.iconTheme = {
      name = "Papirus-Dark";
      package = pkgs.papirus-icon-theme;
    };

    qt.enable = true;
    qt.platformTheme = "gtk";
    qt.style.name = "adwaita-dark";
    qt.style.package = pkgs.adwaita-qt;

    home.pointerCursor = {
      gtk.enable = true;
      x11.enable = true;
      package = pkgs.bibata-cursors;
      name = "Bibata-Modern-Ice";
      size = 24;
    };

    gtk.gtk4 = {
      extraConfig = {
        gtk-application-prefer-dark-theme = 1;
      };
    };

    gtk.gtk3 = {
      extraConfig = {
        gtk-application-prefer-dark-theme = 1;
      };
    };

    dconf.settings = {
      # set dark theme for gtk 4
      "org/gnome/desktop/interface" = {
        color-scheme = "prefer-dark";
      };
    };

    services.gammastep = {
      enable = true;
      provider = "manual";
      latitude = 23.030357;
      longitude = 72.517845;
    };
  };
}
