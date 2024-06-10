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
      plugins = with pkgs.vimPlugins; [
        alpha-nvim
        neorg
        neorg-telescope
        neoformat
        none-ls-nvim
        auto-session
        bufferline-nvim
        dressing-nvim
        indent-blankline-nvim
        nvim-treesitter.withAllGrammars
        nvim-treesitter-context
        lualine-nvim
        nvim-autopairs
        which-key-nvim
        nvim-web-devicons
        nvim-cmp
        nvim-surround
        nvim-lspconfig
        cmp-nvim-lsp
        cmp-buffer
        luasnip
        cmp_luasnip
        friendly-snippets
        lspkind-nvim
        lspsaga-nvim
        comment-nvim
        nvim-ts-context-commentstring
        leap-nvim
        {
          plugin = catppuccin-nvim;
          config = "colorscheme catppuccin-frappe";
        }
        # onedark-nvim
        plenary-nvim
        neodev-nvim
        luasnip
        telescope-nvim
        todo-comments-nvim
        # nvim-tree-lua
        telescope-fzf-native-nvim
        vim-tmux-navigator
      ];
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
                ${builtins.readFile ./plugins/leap-nvim.lua}


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
