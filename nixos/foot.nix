{ pkgs, config, ... }: {
  programs.foot = {
    # catppuccin.enable = true;
    enable = true;
    settings = {
      key-bindings = {
        scrollback-up-line = "Control+Shift+k";
        scrollback-down-line = "Control+Shift+j";
      };
      main = {
        term = "foot";
        font = "JetBrainsMono Nerd Font:size=9.5";
        dpi-aware = "yes";
      };
      scrollback = {
        lines = "5000";
        multiplier = "2";
        indicator-format = "percentage";
        indicator-position = "fixed";
      };
      colors = {
        background = "282828";
        foreground = "ebdbb2";
        regular0 = "282828";
        regular1 = "cc241d";
        regular2 = "98971a";
        regular3 = "d79921";
        regular4 = "458588";
        regular5 = "b16286";
        regular6 = "689d6a";
        regular7 = "a89984";
        bright0 = "928374";
        bright1 = "fb4934";
        bright2 = "b8bb26";
        bright3 = "fabd2f";
        bright4 = "83a598";
        bright5 = "d3869b";
        bright6 = "8ec07c";
        bright7 = "ebdbb2";
      };
    };
  };
}
