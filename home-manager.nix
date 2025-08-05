{
  config,
  pkgs,
  # inputs,
  userSettings,
  lib,
  pkgs-Unstable,
  ...
}:
# ... is called ellipsis
let
  username = userSettings.username;
in
{
  # home-manager.users.coco = {
  imports = [ ./modules ];

  home = {
    inherit (userSettings) username;
    homeDirectory = "/home/" + userSettings.username;

    #The home.stateVersion option does not have a default and must be set
    stateVersion = "23.11";

    #Here goes the rest of your home-manager config, e.g. home.packages = [ pkgs.foo ];
    packages = with pkgs; [
      neovim
      wdisplays
      vscode-fhs
      geogebra6
      hyprpicker
      blender
      asciinema # for terminal recording in txt lol idk
      vesktop
      (lib.hiPrio (
        pkgs.writeShellScriptBin "vesktop" ''
          exec ${pkgs.vesktop}/bin/vesktop --enable-wayland-ime --wayland-text-input-version=3 "$@"
        ''
      ))
      obsidian
      (lib.hiPrio (
        pkgs.writeShellScriptBin "obsidian" ''
          exec ${pkgs.obsidian}/bin/obsidian --enable-wayland-ime --wayland-text-input-version=3 "$@"
        ''
      ))
      pkgs-Unstable.foliate
      zoom-us
      brave
      protonvpn-gui
      openvpn
      prismlauncher
      calibre
      distrobox
      superTuxKart
      yazi
      gimp
      pkgs-Unstable.waybar
      rofi-wayland
      legcord
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
      # lazygit
      tree
      btop
      signal-desktop
      gnome-clocks
      newsflash
      shortwave # radio
    ];

    sessionVariables = {
      GIO_EXTRA_MODULES = "${pkgs.gvfs}/lib/gio/modules";
    };
  };

  xdg.configFile = {
    # you don't have to rebuild..., but have to give full path..
    "sway/config".source =
      config.lib.file.mkOutOfStoreSymlink "/home/${username}/nixos-dotfiles/modules/config/sway/config";

    "river/init".source =
      config.lib.file.mkOutOfStoreSymlink "/home/${username}/nixos-dotfiles/modules/config/river/init";

    "rofi/config.rasi".source =
      config.lib.file.mkOutOfStoreSymlink "/home/${username}/nixos-dotfiles/modules/config/rofi/config.rasi";
    "rofi/tokyonight.rasi".source =
      config.lib.file.mkOutOfStoreSymlink "/home/${username}/nixos-dotfiles/modules/config/rofi/tokyonight.rasi";

    "waybar/config.jsonc".source =
      config.lib.file.mkOutOfStoreSymlink "/home/${username}/nixos-dotfiles/modules/config/waybar/config.jsonc";
    "waybar/style.css".source =
      config.lib.file.mkOutOfStoreSymlink "/home/${username}/nixos-dotfiles/modules/config/waybar/style.css";

    "foot/foot.ini".source =
      config.lib.file.mkOutOfStoreSymlink "/home/${username}/nixos-dotfiles/modules/gui/foot/foot.ini";

    # u have to rebuild but don't need to give full path...
    "nixpkgs/config.nix".source = ./modules/config/nixpkgs/config.nix;
    "direnv/direnv.toml".source = ./modules/config/direnv/direnv.toml;
  };

  home.file = {
    ".ignore".source = ./modules/config/home/.ignore;
    ".inputrc".source = ./modules/config/home/.inputrc;

    ".config/wlogout" = {
      source = ./modules/config/wlogout; # Path to the source directory you want to symlink
      recursive = true;
    };
  };
}
