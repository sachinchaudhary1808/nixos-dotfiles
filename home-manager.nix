{ config, pkgs, inputs, userSettings, ... }:
let
in {
  # home-manager.users.coco = {
  imports = [ ./modules/default.nix ./nvim/neovim.nix ];

  colorScheme = inputs.nix-colors.colorSchemes.catppuccin-mocha;

  catppuccin.flavor = "frappe";

  home = {
    username = userSettings.username;
    homeDirectory = "/home/" + userSettings.username;

    #The home.stateVersion option does not have a default and must be set
    stateVersion = "23.11";

    sessionVariables = {
      EDITOR = "nvim";
      GIO_EXTRA_MODULES = "${pkgs.gvfs}/lib/gio/modules";
    };

    #Here goes the rest of your home-manager config, e.g. home.packages = [ pkgs.foo ];
    packages = with pkgs; [
      distrobox
      # inputs.nixvim-config.packages.${system}.default
      black
      foot
      superTuxKart
      swww
      # neovim
      swaynotificationcenter
      # news
      liferea
      newsflash
      yazi
      emacs-gtk
      #image editing and etc...
      gimp
      waybar
      rofi-wayland
      vesktop
      wmenu
      cmatrix
      element-desktop
      pciutils
      libsForQt5.konversation
      gnome.gnome-system-monitor
      trash-cli
      tldr
      minetestclient
      nix-tree
      steam-run
      gnome-frog
      ttyper
      nomacs

      upower
      telegram-desktop

      bottles
      spotube

      vscode

      lazygit
      geoclue2

      tree
      freetube

      mullvad-vpn
    ];
  };

  xdg.configFile = {
    # you don't have to rebuild..., but have to give full path..
    "sway/config".source = config.lib.file.mkOutOfStoreSymlink
      "/home/coco/nixos-dotfiles/modules/config/sway/config";
    "rofi/config.rasi".source = config.lib.file.mkOutOfStoreSymlink
      "/home/coco/nixos-dotfiles/modules/config/rofi/config.rasi";
    "rofi/tokyonight.rasi".source = config.lib.file.mkOutOfStoreSymlink
      "/home/coco/nixos-dotfiles/modules/config/rofi/tokyonight.rasi";
    #"foot/foot.ini".source = config.lib.file.mkOutOfStoreSymlink "/home/coco/nixos-dotfiles/nixos/foot/foot.ini";
    #"swaylock/config".source = config.lib.file.mkOutOfStoreSymlink "/home/coco/nixos-dotfiles/nixos/swaylock/config";
    "waybar/config.jsonc".source = config.lib.file.mkOutOfStoreSymlink
      "/home/coco/nixos-dotfiles/modules/config/waybar/config.jsonc";
    "waybar/style.css".source = config.lib.file.mkOutOfStoreSymlink
      "/home/coco/nixos-dotfiles/modules/config/waybar/style.css";
    #
    # u have to rebuild but don't need to give full path...
    "nixpkgs/config.nix".source = ./modules/config/nixpkgs/config.nix;
  };

  # programs.home-manager.enable = true;
  # };

  programs.bat = {
    enable = true;
    catppuccin.enable = true;
  };
}
