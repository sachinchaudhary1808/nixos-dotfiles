{ pkgs, config, ... }: {
  imports = [
    # user-system programms
    ./user-system/bash.nix
    ./user-system/startship.nix
    ./user-system/theme.nix
    ./user-system/zoxide.nix

    # gui programms
    ./gui/gammastep.nix
    ./gui/zathura.nix

    # tui programms
    ./tui/yazi.nix
    ./tui/git.nix
    ./tui/tmux/tmux.nix

    # services
  ];
}
