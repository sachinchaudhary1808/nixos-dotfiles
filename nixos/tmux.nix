{
  pkgs,
  config,
  ...
}: {
  programs.tmux = {
    enable = true;
    sensibleOnTop = true;
    plugins = with pkgs; 
      [
 {plugin = tmuxPlugins.sensible;}
 ];
    # escapeTime = 0;
  };
}
