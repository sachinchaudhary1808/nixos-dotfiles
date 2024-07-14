vim.o.makeprg = "gcc % -o %<"
vim.o.shellpipe = ">%s 2>&1 "

-- Function to compile and run the program
local function compile_and_run()
	vim.cmd("w") -- Save the current file
	vim.cmd("make") -- Run makeprg

	-- Check if there was an error
	if vim.v.shell_error == 0 then
		-- Close the quickfix window if it is open
		vim.cmd("cclose")
		-- Open a new terminal window and run the compiled program
		vim.cmd("belowright split | terminal ./%<")
	else
		-- Open the quickfix window to display compilation errors
		vim.cmd("copen")
		-- Map Enter to close the quickfix window
		vim.api.nvim_buf_set_keymap(0, "n", "<CR>", ":cclose<CR>", { noremap = true, silent = true })
	end
end

-- Keybind to compile and run the program in a new terminal window
vim.keymap.set("n", "<leader>d", compile_and_run, { desc = "Compile and run the code in a new terminal" })
