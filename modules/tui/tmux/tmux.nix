{
  pkgs,
  config,
  ...
}: {
  programs.tmux = {
    enable = true;
    sensibleOnTop = true;
    plugins = with pkgs; [
      {plugin = tmuxPlugins.sensible;}
      {plugin = tmuxPlugins.vim-tmux-navigator;}
      {plugin = tmuxPlugins.resurrect;}
    ];

    extraConfig = ''
      ${builtins.readFile ./tmux.conf}

    '';
  };
  home.packages = with pkgs; [];
}
