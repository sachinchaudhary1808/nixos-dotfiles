require("telescope").setup({
	extensions = {
		fzf = {
			fuzzy = true, -- false will only do exact matching
			override_generic_sorter = true, -- override the generic sorter
			override_file_sorter = true, -- override the file sorter
			case_mode = "smart_case", -- or "ignore_case" or "respect_case"
			-- the default case_mode is "smart_case"
		},
	},
})

require("telescope").load_extension("fzf")

local builtin = require("telescope.builtin")
vim.keymap.set("n", "<leader>ff", builtin.find_files, { desc = "find-files" })
vim.keymap.set("n", "<leader>gf", builtin.git_files, { desc = "find git files" })
vim.keymap.set("n", "<leader>fg", builtin.live_grep, { desc = "live string grep" })
vim.keymap.set("n", "<leader>fb", builtin.buffers, { desc = "find buffers" })
vim.keymap.set("n", "<leader>fh", builtin.help_tags, { desc = "help tags" })
vim.keymap.set("n", "<leader>ft", "<cmd>TodoTelescope<cr>", { desc = "Find todos" })
vim.keymap.set("n", "<leader>fb", "<cmd>Telescope file_browser<cr>", { desc = "telescope file browsing" })
