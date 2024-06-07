{
  programs = {
    starship = {
      enable = true;
      enableBashIntegration = true;
      enableFishIntegration = true;
      enableZshIntegration = true;
      settings = {
        character = {
          vimcmd_symbol = "[❮](bold green)";
          vimcmd_replace_one_symbol = "[❮](bold purple)";
          vimcmd_replace_symbol = "[❮](bold purple)";
          vimcmd_visual_symbol = "[❮](bold yellow)";
        };
      };
    };
  };
}
