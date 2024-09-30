{ pkgs, config, ... }: {

  programs.tmux = {
    enable = true;
    tmuxinator.enable = true;
    # newSession = true;
    sensibleOnTop = true;
    plugins = with pkgs; [
      { plugin = tmuxPlugins.sensible; }
      { plugin = tmuxPlugins.vim-tmux-navigator; }
      { plugin = tmuxPlugins.resurrect; }
      {
        plugin = tmuxPlugins.yank;
      }
      # {
      #   plugin = tmuxPlugins.power-theme;
      #   extraConfig = ''
      #     set -g @tmux_power_theme 'snow'
      #   '';
      # }
      # {
      # plugin = tmuxPlugins.catppuccin;
      # extraConfig = ''
      #
      #   set -g @catppuccin_window_left_separator ""
      #   set -g @catppuccin_window_right_separator " "
      #   set -g @catppuccin_window_middle_separator " █"
      #   set -g @catppuccin_window_number_position "right"
      #
      #   set -g @catppuccin_window_default_fill "number"
      #   set -g @catppuccin_window_default_text "#W"
      #
      #   set -g @catppuccin_window_current_fill "number"
      #   set -g @catppuccin_window_current_text "#W"
      #
      #   set -g @catppuccin_status_modules_right "directory user host session"
      #   set -g @catppuccin_status_left_separator  " "
      #   set -g @catppuccin_status_right_separator ""
      #   set -g @catppuccin_status_fill "icon"
      #   set -g @catppuccin_status_connect_separator "no"
      #
      #   set -g @catppuccin_directory_text "#{pane_current_path}"
      #
      # '';
      # }
      # { plugin = tmuxPlugins.tmux-colors-solarized; }
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
      set -sa terminal-overrides ",xterm*:Tc"

      # open panes in current directory
      bind '"' split-window -v -c "#{pane_current_path}"
      bind % split-window -h -c "#{pane_current_path}"








    '';
  };
}
