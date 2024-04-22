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
  home.username = "coco";
  home.homeDirectory = "/home/coco";

  colorScheme = inputs.nix-colors.colorSchemes.equilibrium-dark;
  /*
  The home.stateVersion option does not have a default and must be set
  */
  home.stateVersion = "23.11";
  /*
  Here goes the rest of your home-manager config, e.g. home.packages = [ pkgs.foo ];
  */

  home.packages = with pkgs; [
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
    
  ];


  xdg.configFile."sway/config".source = config.lib.file.mkOutOfStoreSymlink "/home/coco/nixos-dotfiles/nixos/sway/config";
  xdg.configFile."rofi/config.rasi".source = config.lib.file.mkOutOfStoreSymlink "/home/coco/nixos-dotfiles/nixos/rofi/config.rasi";
  xdg.configFile."rofi/tokyonight.rasi".source = config.lib.file.mkOutOfStoreSymlink "/home/coco/nixos-dotfiles/nixos/rofi/tokyonight.rasi";
  # xdg.configFile."foot/foot.ini".source = config.lib.file.mkOutOfStoreSymlink "/home/coco/nixos-dotfiles/nixos/foot/foot.ini";
  # xdg.configFile."swaylock/config".source = config.lib.file.mkOutOfStoreSymlink "/home/coco/nixos-dotfiles/nixos/swaylock/config";
  xdg.configFile."waybar/config.jsonc".source = config.lib.file.mkOutOfStoreSymlink "/home/coco/nixos-dotfiles/nixos/waybar/config.jsonc";
  xdg.configFile."waybar/style.css".source = config.lib.file.mkOutOfStoreSymlink "/home/coco/nixos-dotfiles/nixos/waybar/style.css";

  home.sessionVariables = {
    EDITOR = "nvim";
        GIO_EXTRA_MODULES = "${pkgs.gvfs}/lib/gio/modules";

  };
  # programs.home-manager.enable = true;
  # };
}
