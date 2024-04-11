{
  config,
  pkgs,
  inputs,
  ...
}: let
in {
  imports = [
    # inputs.nixvim.homeManagerModules.nixvim
    #
    #
    # inputs.nixvim.homeManagerModules.nixvim
    #
    #
    # ./nixvim.nix
  ];

  home-manager.users.coco = {
    /*
    The home.stateVersion option does not have a default and must be set
    */
    home.stateVersion = "23.11";
    /*
    Here goes the rest of your home-manager config, e.g. home.packages = [ pkgs.foo ];
    */

    imports = [
      ./nixos/default.nix
    ];
    home.packages = with pkgs; [
      atool
      httpie
      cinnamon.nemo
      distrobox
      black
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
    ];

   
    home.file.".config/foot/foot.ini".source = ./nixos/foot/foot.ini;
    home.file.".config/waybar/config.jsonc".source = ./nixos/waybar/config.jsonc;
    home.file.".config/waybar/style.css".source = ./nixos/waybar/style.css;
    home.file.".config/alacritty/alacritty.toml".source = ./nixos/alacritty/alacritty.toml;
    home.file.".config/sway/config".source = ./nixos/sway/config;
    home.file.".config/swaylock/config".source = ./nixos/swaylock/config;
  };
}
