{ config, pkgs,
# inputs,
userSettings, lib, pkgs-Unstable, ... }:
# ... is called ellipsis
let username = userSettings.username;
in {
  # home-manager.users.coco = {
  imports = [ ./modules ];

  home = {

    inherit (userSettings) username;
    homeDirectory = "/home/" + userSettings.username;

    #The home.stateVersion option does not have a default and must be set
    stateVersion = "23.11";

    #Here goes the rest of your home-manager config, e.g. home.packages = [ pkgs.foo ];
    packages = with pkgs; [
      vscode-fhs
      ghostty
      blanket
      eog
      gemini-cli
      neovim
      wdisplays
      geogebra6
      hyprpicker
      blender
      asciinema # for terminal recording in txt lol idk
      vesktop
      (lib.hiPrio (pkgs.writeShellScriptBin "vesktop" ''
        exec ${pkgs.vesktop}/bin/vesktop --enable-wayland-ime --wayland-text-input-version=3 "$@"
      ''))
      obsidian
      (lib.hiPrio (pkgs.writeShellScriptBin "obsidian" ''
        exec ${pkgs.obsidian}/bin/obsidian --enable-wayland-ime --wayland-text-input-version=3 "$@"
      ''))
      pkgs-Unstable.foliate
      zoom-us
      protonvpn-gui
      openvpn
      prismlauncher
      calibre
      distrobox
      superTuxKart
      yazi
      gimp
      pkgs-Unstable.waybar
      rofi
      legcord
      # element-desktop
      pciutils
      gnome-system-monitor
      trash-cli
      tealdeer
      lunar-client
      nix-tree
      yt-dlp
      steam-run
      tesseract
      keypunch
      # lazygit
      tree
      btop
      signal-desktop
      gnome-clocks
      newsflash
      shortwave # radio
      xwayland-satellite
      woomer
      wl-mirror
      lazygit
      komikku
      gnome-software
    ];

    sessionVariables = { GIO_EXTRA_MODULES = "${pkgs.gvfs}/lib/gio/modules"; };
  };

  xdg.configFile = {
    "cosmic".source =
      config.lib.file.mkOutOfStoreSymlink "/home/${username}/cosmic";
    "zed".source = config.lib.file.mkOutOfStoreSymlink
      "/home/${username}/nixos-dotfiles/modules/config/zed";

    # you don't have to rebuild..., but have to give full path..

    # u have to rebuild but don't need to give full path...
    "nixpkgs/config.nix".source = ./modules/config/nixpkgs/config.nix;
    "direnv/direnv.toml".source = ./modules/config/direnv/direnv.toml;
  };

  home.file = {
    ".ignore".source = ./modules/config/home/.ignore;
    ".inputrc".source = ./modules/config/home/.inputrc;
  };
  programs.zed-editor = {
    enable = true;
    package = pkgs-Unstable.zed-editor;
    extraPackages = with pkgs-Unstable; [ ];

  };
}
