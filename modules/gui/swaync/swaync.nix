{ pkgs, ... }: {
  home = {
    packages = with pkgs; [ swaynotificationcenter ];
    file = { ".config/swaync/config.json".source = ./config.json; };
  };
}
