{ pkgs, config, ... }: {

  programs.tmux = {
    enable = true;
    tmuxinator.enable = true;
    # newSession = true;
    sensibleOnTop = true;
    plugins = with pkgs; [
      { plugin = tmuxPlugins.sensible; }
      { plugin = tmuxPlugins.vim-tmux-navigator; }
      { plugin = tmuxPlugins.onedark-theme; }
    ];

    # escapeTime = 0;
    # keyMode = "vi";
    extraConfig = ''
      set -g prefix M-Space
      set -g mouse on
      bind-key h select-pane -L
      bind-key j select-pane -D
      bind-key k select-pane -U
      bind-key l select-pane -R
      unbind r
      bind r source-file ~/.config/tmux/tmux.conf
      set -ga terminal-overrides ",xterm-256color:Tc"
      set-option -g status-position top




    '';
  };
}
