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

      # One Dark color palette - softer, eye-friendly version
      set default-bg                  "#282c34"
      set default-fg                  "#abb2bf"

      # Status bar colors
      set statusbar-fg                "#abb2bf"
      set statusbar-bg                "#3e4451"

      # Input bar colors
      set inputbar-bg                 "#3e4451"
      set inputbar-fg                 "#abb2bf"

      # Notification colors
      set notification-bg             "#3e4451"
      set notification-fg             "#abb2bf"
      set notification-error-bg       "#e06c75"
      set notification-error-fg       "#282c34"
      set notification-warning-bg     "#e5c07b"
      set notification-warning-fg     "#282c34"

      # Highlight colors - soft yellow and green
      set highlight-color             "#e5c07b"
      set highlight-active-color      "#98c379"

      # Completion colors
      set completion-bg               "#3e4451"
      set completion-fg               "#abb2bf"
      set completion-group-bg         "#3e4451"
      set completion-group-fg         "#61afef"
      set completion-highlight-bg     "#61afef"
      set completion-highlight-fg     "#282c34"

      # Index colors
      set index-bg                    "#282c34"
      set index-fg                    "#abb2bf"
      set index-active-bg             "#3e4451"
      set index-active-fg             "#61afef"

      # Render loading colors
      set render-loading-bg           "#282c34"
      set render-loading-fg           "#abb2bf"

      # Recolor mode - One Dark style recoloring
      set recolor                     true
      set recolor-lightcolor          "#282c34"
      set recolor-darkcolor           "#abb2bf"
      set recolor-reverse-video       true
      set recolor-keephue             true

      # Font settings
      set font                        "JetBrains Mono 11"

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
