{ pkgs, config, lib, ... }: {
  programs.foot = {
    # catppuccin.enable = true;
    enable = true;
    server.enable = true;
  };
}
