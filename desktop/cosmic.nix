{ pkgs, ... }: {
  # Enable the COSMIC login manager
  services.displayManager.cosmic-greeter.enable = true;

  # Enable the COSMIC desktop environment
  services.desktopManager.cosmic.enable = true;

  services.desktopManager.cosmic.xwayland.enable = true;

  # excludePackages
  environment.cosmic.excludePackages = with pkgs; [
    cosmic-edit
    cosmic-ext-applet-privacy-indicator
  ];
  environment.systemPackages = with pkgs; [ cosmic-ext-applet-caffeine ];

}
