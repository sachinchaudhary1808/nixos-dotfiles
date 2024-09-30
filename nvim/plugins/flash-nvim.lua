require("flash").setup({})

-- Set up key mappings
local opts = { noremap = true, silent = true }

-- Normal, Visual, and Operator-pending modes for "s"
vim.api.nvim_set_keymap("n", "s", [[<cmd>lua require('flash').jump()<CR>]], opts)
vim.api.nvim_set_keymap("x", "s", [[<cmd>lua require('flash').jump()<CR>]], opts)
vim.api.nvim_set_keymap("o", "s", [[<cmd>lua require('flash').jump()<CR>]], opts)

-- Normal, Visual, and Operator-pending modes for "S"
vim.api.nvim_set_keymap("n", "S", [[<cmd>lua require('flash').treesitter()<CR>]], opts)
vim.api.nvim_set_keymap("x", "S", [[<cmd>lua require('flash').treesitter()<CR>]], opts)
vim.api.nvim_set_keymap("o", "S", [[<cmd>lua require('flash').treesitter()<CR>]], opts)

-- Operator-pending mode for "r"
vim.api.nvim_set_keymap("o", "r", [[<cmd>lua require('flash').remote()<CR>]], opts)

-- Visual and Operator-pending modes for "R"
vim.api.nvim_set_keymap("x", "R", [[<cmd>lua require('flash').treesitter_search()<CR>]], opts)
vim.api.nvim_set_keymap("o", "R", [[<cmd>lua require('flash').treesitter_search()<CR>]], opts)

-- Command mode for "<c-s>"
vim.api.nvim_set_keymap("c", "<c-s>", [[<cmd>lua require('flash').toggle()<CR>]], opts)
