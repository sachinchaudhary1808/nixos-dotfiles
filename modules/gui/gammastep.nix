{
  services.gammastep = {
    enable = true;
    temperature.day = 5000;
    temperature.night = 2500;
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
