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


  startPlugins =    with vimPlugins; [

        alpha-nvim
        neorg
        neorg-telescope
        neoformat
        none-ls-nvim
        auto-session
        bufferline-nvim
        dressing-nvim
        indent-blankline-nvim
        neocord
        nvim-treesitter.withAllGrammars
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
        # onedark-nvim
        plenary-nvim
        catppuccin-nvim
        neodev-nvim
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
        

  ];

  foldPlugins = builtins.foldl' (
    acc: next:
      acc
      ++ [
        next
      ]
      ++ (foldPlugins (next.dependencies or []))
  ) [];

  startPluginsWithDeps = lib.unique (foldPlugins startPlugins);

  packpath = runCommandLocal "packpath" {} ''
    mkdir -p $out/pack/${packageName}/{start,opt}
    ln -vsfT ${./myplugin} $out/pack/${packageName}/start/myplugin

    ${
       lib.concatMapStringsSep
      "\n"
      (plugin: "ln -vsfT ${plugin} $out/pack/${packageName}/start/${lib.getName plugin}")
      startPluginsWithDeps
    }
     ${
      lib.concatMapStringsSep
      "\n"
      (dep: "ln -vsfT ${dep} $out/pack/${packageName}/start/${lib.getName dep}")
      [
        pkgs.emmet-language-server
        pkgs.lua-language-server
        pkgs.gopls
        pkgs.xclip
        pkgs.wl-clipboard
        pkgs.fd
        pkgs.luajitPackages.lua-lsp
        pkgs.rust-analyzer
        pkgs.nodePackages.bash-language-server
        pkgs.yaml-language-server
        pkgs.python312Packages.jedi-language-server
        pkgs.marksman
        pkgs.black
        pkgs.stylua
        pkgs.prettierd
        pkgs.mypy
        pkgs.pylint
        pkgs.nixfmt-classic
        pkgs.statix
        pkgs.deadnix
        pkgs.nil
      ]
    }
  '';
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
        --add-flags "'set packpath^=${packpath} | set runtimepath^=${packpath}'" \
        --set-default NVIM_APPNAME nvim-custom
    '';

    passthru = {
      inherit packpath;
    };
  }


  
  
  

  
  

