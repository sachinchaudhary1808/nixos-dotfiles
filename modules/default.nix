{
  pkgs,
  config,
  ...
}: {
  imports = [
    # user-system programms
    ./user-system/bash.nix
    ./user-system/startship.nix
    ./user-system/theme.nix
    ./user-system/zoxide.nix

    # gui programms
    ./gui/gammastep.nix
    ./gui/zathura.nix
    ./gui/kitty.nix
    ./gui/foot.nix
    ./gui/swaylock.nix
    ./gui/swaync/swaync.nix

    # tui programms
    ./tui/yazi.nix
    ./tui/git.nix
    ./tui/tmux/tmux.nix
  ];
}
