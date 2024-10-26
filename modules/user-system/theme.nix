{ pkgs, lib, ... }: {

  gtk = {
    enable = true; # Enable GTK theme management
    # catppuccin.enable = true;
    theme = {
      # Choose your theme name and package
      name = "Dracula";
      package = pkgs.dracula-theme;
      # {
      #      # accents = [ "blue" ];
      #      # variant = "mocha";
      #      # size = "compact";
      #    };
    };
  };

  gtk.iconTheme = {
    name = "Papirus-Dark";
    package = pkgs.papirus-icon-theme;
  };

  # qt = {
  #   enable = true;
  #   platformTheme.name = "qtct6";
  #   style.name = "kvantum";
  #
  # };
  qt = {
    enable = true;
    platformTheme.name = "gtk";
    style = {
      name = "gtk2";
      package = pkgs.libsForQt5.qtstyleplugins;
    };
  };

  xdg.configFile = {
    "Kvantum/kvantum.kvconfig".text = ''
      [General]
      theme=catppuccin-mocha-teal
    '';

    "Kvantum/catppuccin-mocha-teal".source = "${
        pkgs.catppuccin-kvantum.override {
          accent = "teal";
          variant = "mocha";
        }
      }/share/Kvantum/catppuccin-mocha-teal";
  };

  home.pointerCursor = {
    gtk.enable = true;
    x11.enable = true;
    package = pkgs.bibata-cursors;
    name = "Bibata-Modern-Ice";
    size = 24;
  };

  gtk.gtk4 = { extraConfig = { gtk-application-prefer-dark-theme = 1; }; };

  gtk.gtk3 = { extraConfig = { gtk-application-prefer-dark-theme = 1; }; };

  # gtk.gtk2 = { extraConfig = { gtk-application-prefer-dark-theme = 1; }; };
  gtk.gtk2 = {
    extraConfig = ''
      gtk-application-prefer-dark-theme=1
    '';
  };

  dconf.settings = {
    # set dark theme for gtk 4
    "org/gnome/desktop/interface" = { color-scheme = "prefer-dark"; };
  };
}
