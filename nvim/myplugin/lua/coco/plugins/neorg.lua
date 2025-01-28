vim.keymap.set("n", "<leader>o", "<cmd>Neorg<cr>", { desc = "open neorg" })

require("neorg").setup({
    load = {
        ["core.defaults"] = {}, -- loads default behaviour
        ["core.concealer"] = {}, -- Adds pretty icons to your documents
        ["core.dirman"] = { -- Managers Neorg workspace
            config = {
                workspaces = {
                    notes = "~/notes",
                },
                default_workspace = "notes",
            },
        },
    },
})

vim.wo.foldlevel = 99
vim.wo.conceallevel = 2
