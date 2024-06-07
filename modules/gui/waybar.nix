{ pkgs, config, lib, host, ... }:
{
programs.waybar = {
    enable = true;
    package = pkgs.waybar;
    settings = 
};

}
