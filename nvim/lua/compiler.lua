-- Create /tmp/bin directory if it doesn't exist
vim.fn.mkdir("/tmp/bin", "p")

-- Function to generate a unique filename based on the current timestamp
local function generate_unique_name()
	return vim.fn.strftime("%Y%m%d%H%M%S")
end

-- Define commands for each filetype
local compile_commands = {
	c = function(unique_name)
		return "gcc % -o " .. unique_name .. " -lm"
	end,
	cpp = function(unique_name)
		return "g++ % -o " .. unique_name .. " -lm"
	end,
	python = function()
		return "python3 %"
	end,
	javascript = function()
		return "node %"
	end,
	go = function()
		-- return "go run % "
		return 'go run "' .. vim.fn.expand("%:p:h") .. '"'
	end,
	lua = function()
		return "lua %"
	end,
	-- Add more languages as needed
}

-- Function to compile and run the program
local function compile_and_run()
	-- Save the current file
	vim.cmd("w")

	-- Get the filetype of the current buffer
	local filetype = vim.bo.filetype

	-- Generate a unique output name in /tmp/bin
	local unique_name = "/tmp/bin/" .. vim.fn.expand("%:t:r") .. "_" .. generate_unique_name()

	-- Get the appropriate compile command for the current filetype
	local compile_cmd
	if compile_commands[filetype] then
		compile_cmd = compile_commands[filetype](unique_name)
	else
		vim.notify("No compile command defined for filetype: " .. filetype, vim.log.levels.ERROR)
		return
	end

	-- Set the makeprg to use the command
	vim.o.makeprg = compile_cmd
	vim.o.shellpipe = ">%s 2>&1"

	-- Run makeprg (compilation or execution)
	vim.cmd("make")

	-- Check if there was an error
	if vim.v.shell_error == 0 then
		-- Close the quickfix window if it is open
		vim.cmd("cclose")

		-- For compiled languages (C, C++, Go), run the binary in a terminal
		if filetype == "c" or filetype == "cpp" then
			vim.cmd("belowright split | terminal " .. unique_name)
		else
			-- For interpreted languages (Python, JavaScript), just run the script
			vim.cmd("belowright split | terminal " .. vim.o.makeprg)
		end
	else
		-- Open the quickfix window to display compilation errors
		vim.cmd("copen")
		-- Map Enter to close the quickfix window
		vim.api.nvim_buf_set_keymap(0, "n", "<CR>", ":cclose<CR>", { noremap = true, silent = true })
	end
end

-- Keybind to compile and run the program in a new terminal window
vim.keymap.set("n", "<leader>d", compile_and_run, { desc = "Compile and run the code in a new terminal" })
