# my nixos configurationconfiguraion
{
  config,
  pkgs,
  inputs,
  userSettings,
  systemSettings,
  pkgs-Unstable,
  ...
}: {
  imports = [
    # Include the results of the hardware scan.
    ./hardware-configuration.nix
  ];

  nix = {
    # using lix insted of nix
    package = pkgs-Unstable.lix;
    nixPath = ["nixpkgs=${inputs.nixpkgs}"];

    # for cachix builds
    settings.extra-substituters = ["https://nix-community.cachix.org"];
    settings.extra-trusted-public-keys = [
      "nix-community.cachix.org-1:mB9FSh9qf2dCimDSUo8Zy7bkq5CX+/rkCWyvRCYg3Fs="
    ];
  };
  # services.xremap = {
  #   withWlroots = true;
  #   userName = userSettings.username;
  #   config.modmap = [{
  #
  #     name = "Global";
  #     remap = { "CapsLock" = "Esc"; }; # globally remap CapsLock to Esc
  #     remap = { "Esc" = "CapsLock"; }; # globally remap Esc to CapsLock
  #
  #   }];
  # };

  # Bootloader.
  # boot.loader.grub.splashImage = null;
  # boot.loader.grub.useOSProber = true;
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
  networking.nameservers = ["1.1.1.1"];

  # Enable networking
  networking.networkmanager.enable = true;
  networking.networkmanager.dns = "default";

  #  disable dhcpcd u don't need if u use network manager
  networking.dhcpcd.enable = false;
  networking.networkmanager.wifi.backend = "iwd";
  networking.wireless.iwd.settings = {
    IPv6 = {Enabled = true;};
    Settings = {AutoConnect = true;};
  };

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
  services.xserver.videoDrivers = ["amdgpu"];
  boot.initrd.kernelModules = ["amdgpu"];
  # # Enable firmware update service
  services.fwupd.enable = true;

  services.power-profiles-daemon.enable = true;

  # dbus u power
  services.upower.enable = true;

  # geoclue2
  # services.geoclue2.enable = true;

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
    packages = with pkgs; [terminus_font powerline-fonts];
    keyMap = "us";
  };

  i18n.inputMethod = {
    enable = true;
    type = "fcitx5";
    fcitx5.waylandFrontend = true;
    fcitx5.addons = with pkgs; [
      fcitx5-m17n
      fcitx5-gtk
      libsForQt5.fcitx5-qt
    ];
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

  # Configure keymap in X11
  # services.xserver = {

  #  xkb.layout = "us";
  # xkb.variant = "";
  # enable = true;
  # };

  #systemd.services."getty@tty1".enable = false;
  #systemd.services."autovt@tty1".enable = false;

  # Define a user account. Don't forget to set a password with ‘passwd’.
  users.users.${userSettings.username} = {
    isNormalUser = true;
    description = userSettings.name;
    extraGroups = ["networkmanager" "wheel" "video" "kvm" "input" "audio" "render"];
    packages = with pkgs; []; # just used nil to not have empty code lol
  };

  nixpkgs = {
    # Allow unfree packages
    config = {allowUnfree = true;};
    # nixpkgs.config.allowUnfree = true;
    config.allowInsecure = true;
    config.permittedInsecurePackages = [
      "electron-27.3.11"
      "electron-33.4.11"
    ];
  };

  services = {
    blueman.enable = true;
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

    greetd = {
      enable = true;
      settings = {
        default_session = {
          command = "${pkgs.greetd.tuigreet}/bin/tuigreet --time --time-format '%I:%M %p | %a • %h | %F' --cmd sway --theme 'border=magenta;text=cyan;prompt=green;time=red;action=blue;button=yellow;container=black;input=red'";
          user = "greeter";
        };
      };
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

  # unlock keyring on login

  #   services.xserver.enable = true;sway
  # services.xserver.displayManager.gdm.enable = true;
  # services.xserver.desktopManager.gnome.enable = true;
  # List packages installed in system profile. To search, run:
  # $ nix search wget
  environment.systemPackages = with pkgs; [
    # Do not forget to add an editor to edit configuration.nix! The Nano editor is also installed by default.
    # some good nix tools
    nixd
    gnome-calculator
    river
    kdiskmark
    deadnix
    # unstable.veloren
    statix
    wget
    mangohud
    protonup
    heroic
    greetd.tuigreet
    i2p
    bat
    cachix
    foot
    alejandra
    swayidle
    swaylock
    # swaylock-effects
    snapshot
    kitty
    rclone
    alacritty
    xorg.xmodmap
    libinput
    qpwgraph
    blueman
    wl-clipboard
    brightnessctl
    android-tools
    playerctl
    wev
    go-mtpfs
    scrcpy
    cmake
    gnumake
    acpi
    xarchiver
    baobab
    transmission_4-gtk
    warpinator
    tor-browser
    # (brave.override { vulkanSupport = true; })
    firefox-esr
    fzf
    gcc
    keepassxc
    htop
    powertop
    git
    gnome-keyring
    glow
    lxqt.lxqt-policykit
    # polkit_gnome
    xorg.xhost
    gparted
    libnotify
    amdgpu_top
    appimage-run
    mpv
    meson
    nitch
    ninja
    dbus
    networkmanagerapplet
    pavucontrol
    pkg-config
    python312
    trash-cli
    wlroots
    xdg-utils
    ripgrep
    fd
    unzip
    obs-studio
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
    # jdk17

    pkgs-Unstable.libreoffice
    fcitx5-configtool
  ];

  #polkit service
  security.polkit.enable = true;

  # systemd = {
  #   user.services.polkit-gnome-authentication-agent-1 = {
  #     description = "polkit-gnome-authentication-agent-1";
  #     wantedBy = [ "graphical-session.target" ];
  #     wants = [ "graphical-session.target" ];
  #     after = [ "graphical-session.target" ];
  #     serviceConfig = {
  #       Type = "simple";
  #       ExecStart =
  #         "${pkgs.polkit_gnome}/libexec/polkit-gnome-authentication-agent-1";
  #       Restart = "on-failure";
  #       RestartSec = 1;
  #       TimeoutStopSec = 10;
  #     };
  #   };
  # };

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
    wlr.enable = true;
    extraPortals = [pkgs.xdg-desktop-portal-gtk];
  };

  #fonts
  fonts.enableDefaultPackages = true;
  fonts.packages = with pkgs; [
    nerd-fonts.jetbrains-mono
    nerd-fonts.droid-sans-mono
    nerd-fonts.fira-code
    nerd-fonts.hack
    font-awesome
    liberation_ttf
    noto-fonts

    lohit-fonts.gujarati
    lohit-fonts.devanagari
    fira-sans
    fira-code
  ];

  fonts.fontconfig = {
    enable = true;
    defaultFonts = {
      serif = ["Liberation Serif"];
      sansSerif = ["Noto Sans"];
      monospace = ["Fira Code"];
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

  #nixpkgs.overlays = [
  #(self: super: {
  # waybar = super.waybar.overrideAttrs (oldAttrs: {
  #	mesonFlags = oldAttrs.mesonFlags ++ [ "-Dexperimental=true" ];
  #	});
  # })
  # ];

  environment.sessionVariables = {
    GTK_IM_MODULE = "fcitx";
    QT_IM_MODULE = "fcitx";
    XMODIFIERS = "@im=fcitx";
    SDL_IM_MODULE = "fcitx";
    GLFW_IM_MODULE = "ibus"; # Some Electron apps use this
    # WLR_NO_HARDWARE_CURSORS = "1";
    NIXOS_OZONE_WL = "1";

    ACCESSIBILITY_ENABLED = "1";
    NH_FLAKE = "/home/${userSettings.username}/nixos-dotfiles";
  };

  #experimantlal features
  nix.settings.experimental-features = ["nix-command" "flakes" "repl-flake"];

  # settings of obs
  boot = {
    kernelModules = ["v4l2loopback"];

    extraModulePackages = [config.boot.kernelPackages.v4l2loopback];
  };

  #masked services
  systemd.services.NetworkManager-wait-online.enable = false;

  #xwayland
  programs.xwayland.enable = true;

  # #sway graphical session target
  # systemd.user.targets.sway-session = {
  #   description = "sway compositor session";
  #   documentation = [ "man:systemd.special(7)" ];
  #   bindsTo = [ "graphical-session.target" ];
  #   wants = [ "graphical-session-pre.target" ];
  #   after = [ "graphical-session-pre.target" ];
  # };

  #sway
  programs.sway = {
    enable = true;
    xwayland.enable = true;
    wrapperFeatures.gtk = true; # so that gtk works properly
    extraPackages = with pkgs; [
      sway-audio-idle-inhibit
      imv
      wlogout
      eyedropper
      swww
      slurp
      grim
    ];
    extraSessionCommands = "export MOZ_ENABLE_WAYLAND=1    ";
  };

  security.pam.loginLimits = [
    {
      domain = "@users";
      item = "rtprio";
      type = "-";
      value = 1;
    }
  ];
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

  #thunar file-manager
  programs.thunar = {
    enable = true;
    plugins = with pkgs.xfce; [
      thunar-archive-plugin
      thunar-volman
      thunar-dropbox-plugin
    ];
  };
  # thunar to open things in terminal
  xdg.terminal-exec = {
    enable = true;
    settings.default = ["foot.desktop"];
  };

  programs.nautilus-open-any-terminal.enable = true;
  services.gvfs = {enable = true;};

  xdg.mime.defaultApplications = {"image/png" = ["imv.desktop"];};

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
            escape = "capslock";
            capslock = "escape";
          };
        };
      };
    };
  };

  # for the via app to work
  services.udev.extraRules = ''
    # Vial-specific rule
    KERNEL=="hidraw*", SUBSYSTEM=="hidraw", ATTRS{serial}=="*vial:f64c2b3c*", MODE="0660", GROUP="users", TAG+="uaccess", TAG+="udev-acl"

    # Generic rule for VIA (and other hidraw devices)
    KERNEL=="hidraw*", SUBSYSTEM=="hidraw", MODE="0660", GROUP="users", TAG+="uaccess", TAG+="udev-acl"
  '';
  services.udev.packages = [pkgs.qmk-udev-rules];

  programs.wshowkeys.enable = true;

  #
  # services.geoclue2 = {
  #   enable = true;
  #   enableDemoAgent = true;
  #   appConfig = {
  #     "org.mozilla.firefox" = {
  #       isAllowed = true;
  #       isSystem = true;
  #     };
  #   };
  # };
  # location.provider = "geoclue2";
  # services.avahi = {
  #   enable = true;
  #   nssmdns = true;
  #   publish = {
  #     enable = true;
  #     addresses = true;
  #     workstation = true;
  #   };
  # };
  services.flatpak.packages = [
  ];
}
