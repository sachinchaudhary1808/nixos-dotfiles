{
  programs.zathura = {
    extraConfig = ''
      set selection-clipboard clipboard
      set padding-page 1
      map u scroll half-up
      map d scroll half-down
      map D toggle_page_mode
      map r rotate
      map i zoom in
      map o zoom out
      map R recolor

    '';

    enable = true;
  };
}
