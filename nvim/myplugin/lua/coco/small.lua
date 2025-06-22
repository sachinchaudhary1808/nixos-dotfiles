-- Plugin setup
require("nvim-surround").setup({})
require("rainbow-delimiters.setup").setup({})
require("ibl").setup()
require("lualine").setup({
    icons_enabled = true,
})
require("fidget").setup({})
require("ccc").setup({
    highlighter = {
        auto_enable = true,
        lsp = true,
    },
})

-- Theme configuration
require("onedark").load()
-- vim.cmd.colorscheme("tokyonight")

-- Fix WinBar color settings
vim.api.nvim_set_hl(0, "WinBar", {
    bold = true, -- Keeps the bold attribute
    bg = "NONE", -- Removes background color
    fg = "NONE", -- Removes foreground color
})
vim.api.nvim_set_hl(0, "WinBarNC", {
    bold = true, -- Keeps the bold attribute
    bg = "NONE", -- Removes background color
    fg = "NONE", -- Removes foreground color
})

-- Ai plugin setup
require("avante_lib").load()
require("avante").setup({
    provider = "copilot",
    mappings = {
        --- @class AvanteConflictMappings
        diff = {
            ours = "co",
            theirs = "ct",
            all_theirs = "ca",
            both = "cb",
            cursor = "cc",
            next = "]x",
            prev = "[x",
        },
        suggestion = {
            accept = "<M-l>",
            next = "<M-]>",
            prev = "<M-[>",
            dismiss = "<C-]>",
        },
        jump = {
            next = "]]",
            prev = "[[",
        },
        submit = {
            normal = "<CR>",
            insert = "<C-s>",
        },
        cancel = {
            normal = { "<C-c>", "<Esc>", "q" },
            insert = { "<C-c>" },
        },
        sidebar = {
            apply_all = "A",
            apply_cursor = "a",
            retry_user_request = "r",
            edit_user_request = "e",
            switch_windows = "<Tab>",
            reverse_switch_windows = "<S-Tab>",
            remove_file = "d",
            add_file = "@",
            close = { "<Esc>", "q" },
            close_from_input = nil, -- e.g., { normal = "<Esc>", insert = "<C-d>" }
        },
    },
})
require("copilot").setup({})

require("direnv").setup({
    autoload_direnv = true,
})
