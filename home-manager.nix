{
  config,
  pkgs,
  inputs,
  ...
}: let
in {
  # home-manager.users.coco = {
  imports = [
    inputs.nix-colors.homeManagerModules.default

    ./nixos/default.nix
  ];

  colorScheme = inputs.nix-colors.colorSchemes.catppuccin-mocha;

  home = {
    username = "coco";
    homeDirectory = "/home/coco";

    #The home.stateVersion option does not have a default and must be set
    stateVersion = "23.11";

    sessionVariables = {
      EDITOR = "nvim";
      GIO_EXTRA_MODULES = "${pkgs.gvfs}/lib/gio/modules";
    };

    #Here goes the rest of your home-manager config, e.g. home.packages = [ pkgs.foo ];
    packages = with pkgs; [
      distrobox
      black
      foot
      superTuxKart
      swww
      swaynotificationcenter
      yazi
      #image editing and etc...
      gimp
      waybar
      rofi-wayland
      vesktop
      wmenu
      gnome.nautilus
      cmatrix
      element-desktop
      pciutils
      libsForQt5.konversation
      gnome.gnome-system-monitor
      trash-cli
      tldr
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
    ];
  };

  xdg.configFile = {
    "sway/config".source = config.lib.file.mkOutOfStoreSymlink "/home/coco/nixos-dotfiles/nixos/sway/config";
    "rofi/config.rasi".source = config.lib.file.mkOutOfStoreSymlink "/home/coco/nixos-dotfiles/nixos/rofi/config.rasi";
    "rofi/tokyonight.rasi".source = config.lib.file.mkOutOfStoreSymlink "/home/coco/nixos-dotfiles/nixos/rofi/tokyonight.rasi";
    #"foot/foot.ini".source = config.lib.file.mkOutOfStoreSymlink "/home/coco/nixos-dotfiles/nixos/foot/foot.ini";
    #"swaylock/config".source = config.lib.file.mkOutOfStoreSymlink "/home/coco/nixos-dotfiles/nixos/swaylock/config";
    "waybar/config.jsonc".source = config.lib.file.mkOutOfStoreSymlink "/home/coco/nixos-dotfiles/nixos/waybar/config.jsonc";
    "waybar/style.css".source = config.lib.file.mkOutOfStoreSymlink "/home/coco/nixos-dotfiles/nixos/waybar/style.css";
  };
  # programs.home-manager.enable = true;
  # };
}
