{
  services.gammastep = {
    enable = true;
    temperature.day = 6500;
    temperature.night = 3500;
    provider = "manual";
    settings = {
      general = {
        adjustment-method = "wayland";
      };
    };
    latitude = "23.03";
    longitude = "72.52";
  };
}
