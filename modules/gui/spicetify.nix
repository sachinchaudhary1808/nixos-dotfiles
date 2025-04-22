{
  inputs,
  pkgs,
  config,
  ...
}: let
  spicePkgs = inputs.spicetify-nix.legacyPackages.${pkgs.system};
in {
  imports = [inputs.spicetify-nix.homeManagerModules.default];

  home.packages = [pkgs.spotify-cli-linux];

  programs.spicetify = {
    enable = true;
    # theme = spicePkgs.themes.spicetify-themes;
    colorScheme = "";
    enabledCustomApps = with spicePkgs.apps; [];
    enabledExtensions = with spicePkgs.extensions; [
      fullAppDisplay
      shuffle
      hidePodcasts
      adblock
      playNext
      volumePercentage
    ];
  };

  xdg.desktopEntries = {
    spotify = {
      name = "Spicetify";
      exec = "spotify";
      icon = "spotify";
      type = "Application";
    };
  };
}
