{ config, pkgs, inputs, userSettings, systemSettings, pkgs-Unstable, lib, ...
}: {
  imports = [
    # Include the results of the hardware scan.
    ./desktop/cosmic.nix
    ./hardware-configuration.nix
  ];

  nix = {
    # using lix insted of nix
    package = pkgs-Unstable.lix;
    nixPath = [ "nixpkgs=${inputs.nixpkgs}" ];

    # for cachix builds
    settings.extra-substituters = [ "https://nix-community.cachix.org" ];
    settings.extra-trusted-public-keys = [
      "nix-community.cachix.org-1:mB9FSh9qf2dCimDSUo8Zy7bkq5CX+/rkCWyvRCYg3Fs="
    ];
  };

  fileSystems = {
    "/".options = [ "compress=zstd" "noatime" ];
    "/home".options = [ "compress=zstd" ];
    "/nix".options = [ "compress=zstd" "noatime" ];
  };

  services.btrfs.autoScrub = {
    enable = true;
    interval = "monthly";
    fileSystems = [ "/" ];
  };

  ## Disabled cuz heavy on ram and stuff
  # services.beesd.filesystems = {
  #   root = {
  #     spec = "LABEL=root";
  #     hashTableSizeMB = 2048;
  #     verbosity = "crit";
  #     extraOptions = [
  #       "--loadavg-target"
  #       "5.0"
  #     ];
  #   };
  # };

  boot.loader = {
    systemd-boot.enable = true;
    grub = {
      enable = false;
      device = "nodev";
      efiSupport = true;
    };
    efi = {
      canTouchEfiVariables = true;
      efiSysMountPoint = "/boot";
    };
  };

  # clean /tmp on every boot
  # boot.tmp.cleanOnBoot = true;

  # networking
  networking.hostName = systemSettings.hostname; # Define your hostname.
  networking.wireless.enable = false; # disble wpa whatever

  # Dns server
  # networking.nameservers = [ "1.1.1.1" ];

  # Enable networking
  networking.networkmanager.enable = true;
  networking.networkmanager.dns = "default";

  #  disable dhcpcd u don't need if u use network manager
  networking.dhcpcd.enable = false;
  ## dosen't work at university iwd
  # networking.networkmanager.wifi.backend = "iwd";
  networking.networkmanager.wifi.backend = "wpa_supplicant";
  # networking.wireless.iwd.settings = {
  #   IPv6 = {
  #     Enabled = true;
  #   };
  #   Settings = {
  #     AutoConnect = true;
  #   };
  # };

  # what to do when lid is closed
  services.logind.lidSwitch = "suspend";
  #kernel settings
  # boot.kernelPackages = pkgs.linuxPackages_latest;

  # boot.kernelPackages = pkgs.linuxPackages_zen;
  #zram settings
  zramSwap.enable = true;
  zramSwap.memoryPercent = 70;
  boot.kernel.sysctl."vm.page-cluster" = 0;

  # Gpu settings
  services.xserver.videoDrivers = [ "amdgpu" ];
  boot.initrd.kernelModules = [ "amdgpu" ];
  # # Enable firmware update service
  services.fwupd.enable = true;

  services.power-profiles-daemon.enable = true;

  # dbus u power
  services.upower.enable = true;

  # geoclue2
  services.geoclue2.enable = true;

  # Configure network proxy if necessary
  # networking.proxy.default = "http://user:password@proxy:port/";
  # networking.proxy.noProxy = "127.0.0.1,localhost,internal.domain";

  # Set your time zone.
  time.timeZone = systemSettings.timeZone;

  # Select internationalisation properties.
  i18n.defaultLocale = systemSettings.locale;

  console = {
    earlySetup = true;
    font = "ter-powerline-v24b";
    packages = with pkgs; [ terminus_font powerline-fonts ];
    keyMap = "us";
  };

  i18n.extraLocaleSettings = {
    LC_ADDRESS = systemSettings.locale;
    LC_IDENTIFICATION = systemSettings.locale;
    LC_MEASUREMENT = systemSettings.locale;
    LC_MONETARY = systemSettings.locale;
    LC_NAME = systemSettings.locale;
    LC_NUMERIC = systemSettings.locale;
    LC_PAPER = systemSettings.locale;
    LC_TELEPHONE = systemSettings.locale;
    LC_TIME = systemSettings.locale;
  };

  # Define a user account. Don't forget to set a password with ‘passwd’.
  users.users.${userSettings.username} = {
    isNormalUser = true;
    description = userSettings.name;
    extraGroups = [
      "networkmanager"
      "wheel"
      "video"
      "kvm"
      "input"
      "audio"
      "render"
      "libvirtd"
    ];
    packages = with pkgs; [ ]; # just used nil to not have empty code lol
  };

  nixpkgs = {
    # Allow unfree packages
    config.allowUnfree = true;
    # nixpkgs.config.allowUnfree = true;
    config.allowInsecure = true;
    config.permittedInsecurePackages = [ "electron-33.4.11" ];
    config.allowUnfreePredicate = pkg:
      builtins.elem (lib.getName pkg) [ "steam" ];
  };

  services = {
    # blueman.enable = true;
    gnome.gnome-keyring.enable = true;
    # setup pipewire for audio
    pipewire = {
      enable = true;
      alsa.enable = true;
      # alsa.support32Bit = true;
      pulse.enable = true;
      jack.enable = true;
      wireplumber.enable = true;
    };

    pulseaudio.enable = false;
    # hardware.pulseaudio.support32Bit = true;

    libinput.enable = true;

    locate = {
      enable = true;
      package = pkgs.mlocate;
    };
  };

  security = {
    rtkit.enable = true;
    pam.services.greetd.enableGnomeKeyring = true;
  };

  hardware = {
    bluetooth.enable = true;
    bluetooth.powerOnBoot = true;
  };

  # List packages installed in system profile. To search, run:
  # $ nix search wget
  environment.systemPackages = with pkgs; [
    # Do not forget to add an editor to edit configuration.nix! The Nano editor is also installed by default.
    # some good nix tools
    unrar
    nixd
    pkgs-Unstable.zed-editor
    nixpkgs-fmt
    nodejs
    gnome-calculator
    kdiskmark
    deadnix
    # unstable.veloren
    statix
    wget
    mangohud
    protonup
    heroic
    lutris
    bat
    cachix
    nixfmt-classic
    # swaylock-effects
    snapshot
    rclone
    xorg.xmodmap
    libinput
    helvum
    # blueman
    wl-clipboard
    android-tools
    playerctl
    wev
    go-mtpfs
    scrcpy
    acpi
    xarchiver
    baobab
    ncdu
    transmission_4-gtk
    warpinator
    tor-browser
    # (brave.override { vulkanSupport = true; })
    nautilus
    fzf
    keepassxc
    htop
    powertop
    git
    gnome-keyring
    glow
    gparted
    libnotify
    amdgpu_top
    appimage-run
    mpv
    dbus
    # networkmanagerapplet
    pavucontrol
    pkg-config
    trash-cli
    xdg-utils
    ripgrep
    fd
    unzip
    v4l-utils
    cliphist
    #podman
    dive # look into docker image layers
    podman-tui # status of containers in the terminal
    docker-compose # start group of containers for dev
    #podman-compose # start group of containers for dev

    # nixos helper
    nh
    #nh helper
    nix-output-monitor
    nvd
    jdk8

    pkgs-Unstable.onlyoffice-desktopeditors
    fcitx5-configtool
    orca
  ];
  programs.steam.enable = true;

  #polkit service
  security.polkit.enable = true;

  # Some programs need SUID wrappers, can be configured further or areconfigurai
  # started in user sessions.
  # programs.mtr.enable = true;
  programs.gnupg.agent = {
    enable = true;
    enableSSHSupport = true;
  };

  services.dbus.enable = true;

  xdg.portal = {
    enable = true;
    # config = {
    #   common = {
    #     default = [ "gtk" ];
    #     "org.freedesktop.impl.portal.ScreenCast" = "gnome";
    #   };
    # };
    extraPortals = with pkgs; [
      xdg-desktop-portal-gtk
      xdg-desktop-portal-cosmic
    ];
  };

  programs.dconf.enable = true;

  #fonts
  fonts.enableDefaultPackages = true;
  fonts.packages = with pkgs; [
    nerd-fonts.jetbrains-mono
    nerd-fonts.fira-code
    corefonts
    font-awesome
    liberation_ttf
    monocraft
    noto-fonts

    lohit-fonts.gujarati
    lohit-fonts.devanagari

    fira-sans
    fira-code
  ];

  fonts.fontconfig = {
    enable = true;
    defaultFonts = {
      serif = [ "Liberation Serif" ];
      sansSerif = [ "Noto Sans" ];
      monospace = [ "Fira Code" ];
    };
  };

  # List services that you want to enable:

  # Enable the OpenSSH daemon.
  services.openssh.enable = true;

  # Open ports in the firewall.
  # networking.firewall.allowedTCPPorts = [ ... ];
  # networking.firewall.allowedUDPPorts = [ ... ];
  # Or disable the firewall altogether.
  networking.firewall.enable = false;

  # This value determines the NixOS release from which the default
  # settings for stateful data, like file locations and database versions
  # on your system were taken. It‘s perfectly fine and recommended to leave
  # this value at the release version of the first install of this system.
  # Before changing this value read the documentation for this option
  # (e.g. man configuration.nix or on https://nixos.org/nixos/options.html).
  system.stateVersion = "23.11"; # Did you read the comment?

  environment.sessionVariables = {
    NIXOS_OZONE_WL = "1";
    NH_FLAKE = "/home/${userSettings.username}/nixos-dotfiles";
    COSMIC_DATA_CONTROL_ENABLED = 1;
  };

  #experimantlal features
  nix.settings.experimental-features = [ "nix-command" "flakes" ];

  programs.obs-studio = {
    enable = true;
    plugins = with pkgs.obs-studio-plugins; [
      wlrobs
      obs-backgroundremoval
      obs-pipewire-audio-capture
      obs-vaapi # optional AMD hardware acceleration
      obs-gstreamer
      obs-vkcapture
    ];
  };
  # settings of obs
  boot = {
    kernelModules = [ "v4l2loopback" ];
    extraModulePackages = [ config.boot.kernelPackages.v4l2loopback ];
  };

  #masked services
  systemd.services.NetworkManager-wait-online.enable = false;

  #xwayland
  programs.xwayland.enable = true;

  security.pam.loginLimits = [{
    domain = "@users";
    item = "rtprio";
    type = "-";
    value = 1;
  }];
  # programs.waybar.enable = true;

  environment.variables = {
    VISUAL = "nvim";
    EDITOR = "nvim";
  };

  virtualisation.waydroid.enable = true;

  virtualisation.libvirtd.enable = true;
  programs.virt-manager.enable = true;

  # Automatic Garbage Collection
  nix.gc = {
    automatic = true;
    dates = "weekly";
    options = "--delete-older-than 7d";
  };
  boot.loader.grub.configurationLimit = 10;
  # nix store auto-optimization
  nix.settings.auto-optimise-store = true;

  virtualisation.containers.enable = true;
  services.flatpak.enable = true;
  virtualisation = {
    podman = {
      enable = true;

      # Create a `docker` alias for podman, to use it as a drop-in replacement
      dockerCompat = true;

      # Required for containers under podman-compose to be able to talk to each other.
      defaultNetwork.settings.dns_enabled = true;
    };
  };

  programs.nautilus-open-any-terminal.enable = true;
  services.gvfs = { enable = true; };

  xdg.mime.defaultApplications = {
    # Microsoft Word documents (.docx)
    "application/vnd.openxmlformats-officedocument.wordprocessingml.document" =
      "writer.desktop";

    # Other potential LibreOffice Writer formats you might want to set:
    # "application/vnd.oasis.opendocument.text" = "writer.desktop"; # OpenDocument Text (.odt)
    # "application/msword" = "writer.desktop"; # Older Microsoft Word formats (.doc)

    # PNG images
    "image/png" = "org.gnome.eog.desktop";

    # Other common image formats (using eog)
    "image/jpeg" = "org.gnome.eog.desktop";
    "image/gif" = "org.gnome.eog.desktop";
    "image/bmp" = "org.gnome.eog.desktop";
    "image/tiff" = "org.gnome.eog.desktop";
    # You can add more image MIME types as needed, using eog.desktop

  };

  # bye bye nano
  # programs.nano.enable = lib.mkForce false;

  # Disable things here

  # documentation.nixos.enable = false;
  programs.appimage.enable = true;

  #enable i2p
  # services.i2p.enable = true;

  # solves  The name org.a11y.Bus was not provided by any .service files.
  services.gnome.at-spi2-core.enable = true;

  #game mode
  programs.gamemode.enable = true;
  programs.gamescope.enable = true;

  # nixos devshell tools
  programs.direnv = {
    enable = true;
    silent = true;
    loadInNixShell = true;
    direnvrcExtra = "";
    nix-direnv = {
      enable = true;
      package = pkgs.nix-direnv;
    };
  };

  services.keyd = {
    enable = true;
    keyboards = {
      default = {
        settings = {
          main = {
            # Maps capslock to escape when pressed and control when held.
            capslock = "overload(control, escape)";
            escape = "capslock";
          };
        };
      };
    };
  };

  environment.etc."libinput/local-overrides.quirks".text = pkgs.lib.mkForce ''
    [Serial Keyboards]
    MatchUdevType=keyboard
    MatchName=keyd virtual keyboard
    AttrKeyboardIntegration=internal
  '';
  # https://github.com/rvaiya/keyd/issues/66#issuecomment-985983524

  # for the via app to work
  services.udev.extraRules = ''
    # Vial-specific rule
    KERNEL=="hidraw*", SUBSYSTEM=="hidraw", ATTRS{serial}=="*vial:f64c2b3c*", MODE="0660", GROUP="users", TAG+="uaccess", TAG+="udev-acl"

    # Generic rule for VIA (and other hidraw devices)
    KERNEL=="hidraw*", SUBSYSTEM=="hidraw", MODE="0660", GROUP="users", TAG+="uaccess", TAG+="udev-acl"
  '';

  services.udev.packages = [ pkgs.qmk-udev-rules ];

  services.flatpak.packages = [ ];

  services.preload.enable = true;

  programs.firefox = {
    enable = true;
    package = pkgs.firefox-esr;
    preferences = {
      # disable libadwaita theming for Firefox
      "widget.gtk.libadwaita-colors.enabled" = false;
    };
  };
  programs.nix-ld.enable = true;
}
