{
  config,
  pkgs,
  inputs,
  userSettings,
  lib,
  ...
}:
# ... is called ellipsis
let
  username = userSettings.username;
in {
  # home-manager.users.coco = {
  imports = [./modules];

  home = {
    inherit (userSettings) username;
    homeDirectory = "/home/" + userSettings.username;

    #The home.stateVersion option does not have a default and must be set
    stateVersion = "23.11";

    sessionVariables = {
      VISUAL = "${lib.getExe pkgs.neovim}";
      GIO_EXTRA_MODULES = "${pkgs.gvfs}/lib/gio/modules";
    };

    #Here goes the rest of your home-manager config, e.g. home.packages = [ pkgs.foo ];
    packages = with pkgs; [
      unstable.foliate
      obsidian
      brave
      prismlauncher
      calibre
      distrobox
      # inputs.nixvim-config.packages.${system}.default
      superTuxKart
      # news
      yazi
      #image editing and etc...
      gimp
      unstable.waybar
      rofi-wayland
      webcord
      vesktop
      element-desktop
      pciutils
      gnome-system-monitor
      trash-cli
      tealdeer
      minetestclient
      nix-tree
      yt-dlp

      steam-run
      gnome-frog
      ttyper

      lazygit

      tree
      btop

      signal-desktop
      gnome-clocks
    ];
  };

  xdg.configFile = {
    # you don't have to rebuild..., but have to give full path..
    "sway/config".source =
      config.lib.file.mkOutOfStoreSymlink
      "/home/${username}/nixos-dotfiles/modules/config/sway/config";
    "river/init".source =
      config.lib.file.mkOutOfStoreSymlink
      "/home/${username}/nixos-dotfiles/modules/config/river/init";

    "rofi/config.rasi".source =
      config.lib.file.mkOutOfStoreSymlink
      "/home/${username}/nixos-dotfiles/modules/config/rofi/config.rasi";
    "rofi/tokyonight.rasi".source =
      config.lib.file.mkOutOfStoreSymlink
      "/home/${username}/nixos-dotfiles/modules/config/rofi/tokyonight.rasi";
    #"foot/foot.ini".source = config.lib.file.mkOutOfStoreSymlink "/home/coco/nixos-dotfiles/nixos/foot/foot.ini";
    #"swaylock/config".source = config.lib.file.mkOutOfStoreSymlink "/home/coco/nixos-dotfiles/nixos/swaylock/config";
    "waybar/config.jsonc".source =
      config.lib.file.mkOutOfStoreSymlink
      "/home/${username}/nixos-dotfiles/modules/config/waybar/config.jsonc";
    "waybar/style.css".source =
      config.lib.file.mkOutOfStoreSymlink
      "/home/${username}/nixos-dotfiles/modules/config/waybar/style.css";
    #
    # u have to rebuild but don't need to give full path...
    "nixpkgs/config.nix".source = ./modules/config/nixpkgs/config.nix;
    "direnv/direnv.toml".source = ./modules/config/direnv/direnv.toml;
  };

  home.file.".ignore".source = ./modules/config/home/.ignore;

  home.file.".config/wlogout" = {
    source =
      ./modules/config/wlogout; # Path to the source directory you want to symlink
    recursive = true;
  };
}
