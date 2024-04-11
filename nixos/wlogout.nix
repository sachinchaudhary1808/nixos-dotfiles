{ config, lib, pkgs, ... }:
{
  programs.wlogout = {
    enable = true;
    layout = [
{
    "label" = "lock";
    "action" = "swaylock";
    "text" = "Lock";
    "keybind" = "l";
}
{
    "label" = "reboot";
    "action" = "systemctl reboot";
    "text" = "Reboot";
    "keybind" = "r";
}
{
    "label" = "shutdown";
    "action" = "systemctl poweroff";
    "text" = "Shutdown";
    "keybind" = "s";
}
{
    "label" = "logout";
    "action" = "pkill sway";
    "text" = "Logout";
    "keybind" = "e";
}
{
    "label" = "suspend";
    "action" = "systemctl suspend";
    "text" = "Suspend";
    "keybind" = "u";
}
    ];
      };
}
