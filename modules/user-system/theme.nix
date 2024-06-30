{ pkgs, ... }: {

  gtk = {
    enable = true; # Enable GTK theme management
    # catppuccin.enable = true;
    theme = {
      # Choose your theme name and package
      name = "catppuccin-mocha-blue-compact+default";
      package = pkgs.catppuccin-gtk.override {
        accents = [ "blue" ];
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
  qt.platformTheme.name = "gtk";
  qt.style.name = "adwaita-dark";
  qt.style.package = pkgs.adwaita-qt;

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

  dconf.settings = {
    # set dark theme for gtk 4
    "org/gnome/desktop/interface" = { color-scheme = "prefer-dark"; };
  };
}
