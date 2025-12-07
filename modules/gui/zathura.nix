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

      # Zathura One Dark Inspired Theme - Easy on Eyes
      # Save this as ~/.config/zathura/zathurarc



      # Scrolling and navigation
      set scroll-page-aware           true
      set scroll-full-overlap         0.01
      set scroll-step                 50
      set zoom-min                    10
      set zoom-max                    1000
      set zoom-step                   10

      # Smooth scrolling
      set smooth-scroll               true

      # Adjust pages to window
      set adjust-open                 "best-fit"
      set pages-per-row               1
      set first-page-column           1

      # Search settings
      set incremental-search          true
      set search-hadjust              true

      # Window settings
      set window-title-basename       true
    '';

    enable = true;
  };
}
