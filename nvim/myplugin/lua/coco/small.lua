require("nvim-surround").setup({})

-- require("onedark").setup({
--     transparent = true,
-- })
require("onedark").load()

-- fix wibar lspsaga black colour to none
vim.api.nvim_set_hl(0, "WinBar", {
    bold = true, -- Keeps the bold attribute
    bg = "NONE", -- Removes background color
    fg = "NONE", -- Removes foreground color
})

require("rainbow-delimiters.setup").setup({})

require("toggleterm").setup()

require("ibl").setup()

require("lualine").setup({
    icons_enabled = true,
    -- theme = 'catppuccin',
})

require("fidget").setup({})

require("precognition").toggle()

-- The setup config table shows all available config options with their default values:
require("presence").setup({})
