{ pkgs, config, ... }: {
  programs = {
    gh.enable = true;
    neovim = {

      enable = true;
      defaultEditor = true;
      viAlias = true;
      vimAlias = true;
      vimdiffAlias = true;
      withNodeJs = true;
      extraPackages = with pkgs; [
        lua-language-server
        gopls
        xclip
        wl-clipboard
        luajitPackages.lua-lsp
        nil
        rust-analyzer
        nodePackages.bash-language-server
        yaml-language-server
        pyright
        marksman
        clang-tools

        #formatters
        black
        nixfmt-classic
        stylua # for none-ls
        prettierd
        mypy
        pylint

      ];
      plugins = (with pkgs.vimPlugins; [
        alpha-nvim
        neorg
        neorg-telescope
        neoformat
        none-ls-nvim
        auto-session
        bufferline-nvim
        dressing-nvim
        indent-blankline-nvim
        # nvim-treesitter.withAllGrammars
        nvim-treesitter-context
        lualine-nvim
        nvim-autopairs
        which-key-nvim
        markdown-preview-nvim
        nvim-web-devicons
        nvim-cmp
        {
          plugin = nvim-surround;
          type = "lua";
          config = ''require("nvim-surround").setup({	})'';
        }
        nvim-lspconfig
        cmp-nvim-lsp
        cmp-buffer
        cmp-path
        luasnip
        cmp_luasnip
        friendly-snippets
        lspkind-nvim
        lspsaga-nvim
        comment-nvim
        nvim-ts-context-commentstring
        flash-nvim
        gitsigns-nvim
        {
          plugin = onedark-nvim;
          type = "lua";
          config = "require('onedark').load()";
        }
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
        {

          plugin = toggleterm-nvim;
          type = "lua";
          config = ''require("toggleterm").setup()'';
        }

      ]) ++ (with pkgs.vimPlugins.nvim-treesitter-parsers; [{
        plugin = pkgs.symlinkJoin {
          name = "nvim-treesitter";
          paths = [
            pkgs.vimPlugins.nvim-treesitter.withAllGrammars
            pkgs.vimPlugins.nvim-treesitter.withAllGrammars.dependencies
          ];
        };
        optional = false;
      }]);

      extraConfig = ''
        set noemoji
      '';
      extraLuaConfig = ''
                ${builtins.readFile ./options.lua}
                ${builtins.readFile ./auto-commands.lua}
                ${builtins.readFile ./keymaps.lua}
                ${builtins.readFile ./plugins/alpha.lua}
                ${builtins.readFile ./plugins/autopairs.lua}
                ${builtins.readFile ./plugins/auto-session.lua}
                ${builtins.readFile ./plugins/comment.lua}
                ${builtins.readFile ./plugins/cmp.lua}
                ${builtins.readFile ./plugins/lsp.lua}
                ${builtins.readFile ./plugins/nvim-tree.lua}
                ${builtins.readFile ./plugins/telescope.lua}
                ${builtins.readFile ./plugins/todo-comments.lua}
                ${builtins.readFile ./plugins/which-key.lua}
                ${builtins.readFile ./plugins/treesitter.lua}
                ${builtins.readFile ./plugins/bufferline-nvim.lua}
                ${builtins.readFile ./plugins/neorg.lua}
                ${builtins.readFile ./plugins/none-ls.lua}
                ${builtins.readFile ./plugins/flash-nvim.lua}
                ${builtins.readFile ./plugins/undotree.lua}
                ${builtins.readFile ./plugins/fugitive.lua}
                ${builtins.readFile ./plugins/gitsings.lua}
                ${builtins.readFile ./plugins/sniprun.lua}
                ${builtins.readFile ./snippites/snip.lua}
                ${builtins.readFile ./plugins/harpoon2.lua}


                require("ibl").setup()
                require("lualine").setup({
                  icons_enabled = true,
                   -- theme = 'catppuccin',
                })

        -- require('onedark').setup {
         --    style = 'darker'
         --}
         -- require('onedark').load()
      '';
    };
  };
}
