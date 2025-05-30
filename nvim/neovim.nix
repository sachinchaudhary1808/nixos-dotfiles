# neovim.nix
{
  symlinkJoin,
  neovim-unwrapped,
  makeWrapper,
  runCommandLocal,
  vimPlugins,
  lib,
  pkgs,
}: let
  packageName = "mypackage";

  optimizedTreesitter = pkgs.symlinkJoin {
    name = "nvim-treesitter-optimized";
    paths = [
      pkgs.vimPlugins.nvim-treesitter.withAllGrammars
      pkgs.vimPlugins.nvim-treesitter.withAllGrammars.dependencies
    ];
  };

  startPlugins =
    (with vimPlugins; [
      precognition-nvim
      trouble-nvim
      fidget-nvim
      alpha-nvim
      oil-nvim
      neoformat
      none-ls-nvim
      auto-session
      bufferline-nvim
      dressing-nvim
      indent-blankline-nvim
      neocord
      nvim-treesitter-context
      lualine-nvim
      nvim-autopairs
      which-key-nvim
      markdown-preview-nvim
      nvim-web-devicons
      nvim-cmp
      nvim-surround
      nvim-lspconfig
      cmp-nvim-lsp
      cmp-buffer
      cmp-path
      luasnip
      cmp_luasnip
      friendly-snippets
      lspkind-nvim
      lspsaga-nvim
      flash-nvim
      gitsigns-nvim
      onedark-nvim
      dracula-nvim
      # onedark-nvim
      plenary-nvim
      catppuccin-nvim
      # neodev-nvim
      luasnip
      telescope-nvim
      telescope-file-browser-nvim
      todo-comments-nvim
      # nvim-tree-lua
      telescope-fzf-native-nvim
      vim-tmux-navigator
      undotree
      sniprun
      vim-fugitive
      harpoon2
      rainbow-delimiters-nvim

      toggleterm-nvim

      # debugging
      nvim-dap
      nvim-dap-ui
      nvim-dap-virtual-text
      nvim-dap-go

      # testing
      vim-test
    ])
    ++ [optimizedTreesitter];

  foldPlugins =
    builtins.foldl'
    (acc: next: acc ++ [next] ++ (foldPlugins (next.dependencies or [])))
    [];

  startPluginsWithDeps = lib.unique (foldPlugins startPlugins);

  packpath = runCommandLocal "packpath" {} ''
    mkdir -p $out/pack/${packageName}/{start,opt}
    ln -vsfT ${./myplugin} $out/pack/${packageName}/start/myplugin

    ${lib.concatMapStringsSep "\n" (plugin: "ln -vsfT ${plugin} $out/pack/${packageName}/start/${lib.getName plugin}")
      startPluginsWithDeps}

  '';
  # Define a list of Nix packages to include
  neovimPackages = with pkgs; [
    lua-language-server
    gopls
    xclip
    wl-clipboard
    fd
    rust-analyzer
    nodePackages.bash-language-server
    yaml-language-server
    # python312Packages.python-lsp-server
    python312Packages.jedi-language-server
    marksman
    # clang-tools

    #formatters
    black
    stylua # for none-ls
    prettierd
    # live-server
    mypy
    pylint

    #nix
    alejandra
    # statix
    deadnix
    nil
  ];
  runtimeAndBinPaths =
    lib.concatMapStringsSep "," (pkg: "${pkg}/share/nvim/runtime")
    neovimPackages;
  binPath = lib.makeBinPath neovimPackages;
in
  symlinkJoin {
    name = "nvim-custom";
    meta.mainProgram = "nvim";
    paths = [neovim-unwrapped];
    nativeBuildInputs = [makeWrapper];
    postBuild = ''
      wrapProgram $out/bin/nvim \
        --add-flags '-u' \
        --add-flags '${./init.lua}' \
        --add-flags '--cmd' \
        --add-flags "'set packpath^=${packpath} | set runtimepath^=${packpath},${runtimeAndBinPaths}'" \
        --prefix PATH ":" ${binPath} \
        --set-default NVIM_APPNAME nvim-custom
    '';

    passthru = {inherit packpath;};
  }
