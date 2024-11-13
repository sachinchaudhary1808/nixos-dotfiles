-- my file
--
--
--
-- In your Neovim config
require("nvim-web-devicons").setup({
    default = true,
    override = {
        default_icon = {
            icon = "•", -- fallback symbol
        },
    },
})
