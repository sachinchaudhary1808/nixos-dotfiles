local keymap = vim.keymap
require("bufferline").setup({
	["options"] = { ["always_show_bufferline"] = false, ["hover"] = { ["enabled"] = false } },
})

-- bufferline keymaps
keymap.set("n", "<Tab>", "<cmd>BufferLineCycleNext<CR>", { desc = "Cycle to next buffer" })
keymap.set("n", "<S-Tab>", "<cmd>BufferLineCyclePrev<CR>", { desc = "Cycle to previous buffer" })

keymap.set("n", "<S-l>", "<cmd>BufferLineCycleNext<CR>", { desc = "Cycle to next buffer" })
keymap.set("n", "<S-h>", "<cmd>BufferLineCyclePrev<CR>", { desc = "Cycle to previous buffer" })
keymap.set("n", "<leader>bd", "<cmd>bdelete<CR>", { desc = "Delete buffer" })
keymap.set("n", "<leader>bb", "<cmd>e #<CR>", { desc = "Switch to Other Buffer" })
keymap.set("n", "<leader>br", "<cmd>BufferLineCloseRight<CR>", { desc = "Delete buffer to the right" })
keymap.set("n", "<leader>bl", "<cmd>BufferLineCloseLeft<CR>", { desc = "Delete buffers to the left" })
keymap.set("n", "<leader>bo", "<cmd>BufferlineCloseOthers<CR>", { desc = "Delete other buffers" })
keymap.set("n", "<leader>bp", "<cmd>BufferLineTogglePin<CR>", { desc = "Toggle pin" })
keymap.set("n", "<leader>bP", "<cmd>BufferLineGroupClose ungrouped<CR>", { desc = "Delete non-pinned buffers" })
