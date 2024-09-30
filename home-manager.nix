{ config, pkgs, inputs, userSettings, ... }: {
  # home-manager.users.coco = {
  imports = [ ./modules ./nvim/neovim.nix ];

  home = {
    inherit (userSettings) username;
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
      superTuxKart
      swww
      # news
      yazi
      #image editing and etc...
      gimp
      unstable.waybar
      rofi-wayland
      vesktop
      element-desktop
      pciutils
      gnome-system-monitor
      trash-cli
      tldr
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
    "direnv/direnv.toml".source = ./modules/config/direnv/direnv.toml;
  };
  home.file.".ignore".source = ./modules/config/home/.ignore;

  # programs.home-manager.enable = true;
  # };

  # services.mpd = {
  #   enable = true;
  #   musicDirectory = "/home/coco/Music";
  #   dataDir = "/home/coco/.local/share/mpd";
  #   dbFile = "/home/coco/.local/share/mpd/database";
  #   network.listenAddress = "any";
  #   network.startWhenNeeded = true;
  #
  #   extraConfig = ''
  #
  #     audio_output {
  #            type "pipewire"
  #            name "My Pipewire output"
  #          }
  #   '';
  # };
  #
  # programs.ncmpcpp = {
  #   enable = true;
  #   mpdMusicDir = "~/Music";
  # };
  wayland.windowManager.sway.systemd.enable = true;

}
