{ pkgs, config, ... }:
{
  imports = [
  ./wlogout.nix
  ./bash.nix
  ./startship.nix
  ./theme.nix
  ./git.nix
  ./gammastep.nix
  ./zoxide.nix
  ];
}
