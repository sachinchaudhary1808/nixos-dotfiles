{
  config,
  pkgs,
  inputs,
  home-manager,
  ...
}: let
in {
  # home-manager.users.coco = {
  imports = [
    # inputs.nixvim.homeManagerModules.nixvim
    #
    #
    # inputs.nixvim.homeManagerModules.nixvim
    #
    #
    # ./nixvim.nix
    ./nixos/default.nix
  ];
home.username = "coco";
home.homeDirectory = "/home/coco";

    /*
    The home.stateVersion option does not have a default and must be set
    */
    home.stateVersion = "23.11";
    /*
    Here goes the rest of your home-manager config, e.g. home.packages = [ pkgs.foo ];
    */

    home.packages = with pkgs; [
      atool
      httpie
      cinnamon.nemo
      distrobox
      black
      btop
      brave
      dex
      foot
      gedit
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
      chromium
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
    ];
xdg.configFile."sway/config".source = config.lib.file.mkOutOfStoreSymlink "/home/coco/mysystem/nixos/sway/config";    
xdg.configFile."rofi/config.rasi".source = config.lib.file.mkOutOfStoreSymlink "/home/coco/mysystem/nixos/rofi/config.rasi";    
xdg.configFile."rofi/tokyonight.rasi".source = config.lib.file.mkOutOfStoreSymlink "/home/coco/mysystem/nixos/rofi/tokyonight.rasi";    
xdg.configFile."foot/foot.ini".source = config.lib.file.mkOutOfStoreSymlink "/home/coco/mysystem/nixos/foot/foot.ini";    
xdg.configFile."swaylock/config".source = config.lib.file.mkOutOfStoreSymlink "/home/coco/mysystem/nixos/swaylock/config";    
xdg.configFile."waybar/config.jsonc".source = config.lib.file.mkOutOfStoreSymlink "/home/coco/mysystem/nixos/waybar/config.jsonc";    
xdg.configFile."waybar/style.css".source = config.lib.file.mkOutOfStoreSymlink "/home/coco/mysystem/nixos/waybar/style.css";    



  

home.sessionVariables = {
    EDITOR = "nvim";
  };
  # programs.home-manager.enable = true;
# };
}
