require("sniprun").setup({})

vim.api.nvim_set_keymap("v", "r", "<Plug>SnipRun", { silent = true })
vim.api.nvim_set_keymap("n", "<leader>ro", "<Plug>SnipRunOperator", { silent = true })
vim.api.nvim_set_keymap("n", "<leader>rr", "<Plug>SnipRun", { silent = true })
vim.api.nvim_set_keymap("n", "<leader>rd", "<Plug>SnipClose", { silent = true })
