{ pkgs, config, ... }: {
  imports = [
    ./wlogout.nix
    ./bash.nix
    ./startship.nix
    ./theme.nix
    ./git.nix
    ./gammastep.nix
    ./zoxide.nix
    ./zathura.nix
    ./kitty.nix
    ./alacritty.nix
    ./foot.nix
    ./swaylock.nix
    ./yazi.nix
    ./tmux.nix
    # ./emacs.nix
  ];
}
