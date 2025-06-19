-- Create /tmp/bin directory if it doesn't exist
vim.fn.mkdir("/tmp/bin", "p")

-- Function to generate a unique filename based on the current timestamp
local function generate_unique_name()
    return vim.fn.strftime("%Y%m%d%H%M%S")
end

-- Define commands for each filetype with their compilation needs
local language_configs = {
    c = {
        needs_compilation = true,
        get_command = function(unique_name)
            return {
                compile = "gcc % -o " .. unique_name .. " -lm",
                run = unique_name,
            }
        end,
    },
    cpp = {
        needs_compilation = true,
        get_command = function(unique_name)
            return {
                compile = "g++ % -o " .. unique_name .. " -lm",
                run = unique_name,
            }
        end,
    },
    python = {
        needs_compilation = false,
        get_command = function()
            return {
                run = "python3 %",
            }
        end,
    },
    javascript = {
        needs_compilation = false,
        get_command = function()
            return {
                run = "node %",
            }
        end,
    },
    go = {
        needs_compilation = false,
        get_command = function()
            return {
                run = 'go run "' .. vim.fn.expand("%:p") .. '"',
            }
        end,
    },
    lua = {
        needs_compilation = false,
        get_command = function()
            return {
                run = "lua %",
            }
        end,
    },
}

-- Function to compile and run the program
local function compile_and_run()
    -- Save the current file
    vim.cmd("w")

    -- Get the filetype of the current buffer
    local filetype = vim.bo.filetype

    -- Check if we have a configuration for this filetype
    local config = language_configs[filetype]
    if not config then
        vim.notify("No configuration defined for filetype: " .. filetype, vim.log.levels.ERROR)
        return
    end

    -- Generate a unique output name in /tmp/bin for compiled languages
    local unique_name
    if config.needs_compilation then
        unique_name = "/tmp/bin/" .. vim.fn.expand("%:t:r") .. "_" .. generate_unique_name()
    end

    -- Get the commands for this filetype
    local commands = config.get_command(unique_name)

    if config.needs_compilation then
        -- For compiled languages
        vim.o.makeprg = commands.compile
        vim.o.shellpipe = ">%s 2>&1"

        -- Compile the program
        vim.cmd("silent make")

        -- Check if compilation was successful
        if vim.v.shell_error == 0 then
            vim.cmd("cclose")
            -- Reuse or create a terminal split for running
            vim.cmd("botright split | terminal " .. commands.run)
        else
            -- Show compilation errors
            vim.cmd("copen")
        end
    else
        -- For interpreted languages, reuse or create a terminal split
        vim.cmd("botright split | terminal " .. commands.run)
    end
end

-- Keybind to compile and run the program in a new terminal split
vim.keymap.set("n", "<leader>cc", compile_and_run, { desc = "Compile and run the code in a terminal split" })

-- Keybind to switch terminal mode manually
-- this is for to make esc disable cuz i use vi mode in terminal and it messhes with neovim's esc keymap, so to go to normal mode u use ctr + esc
vim.keymap.set("t", "<C-Esc>", [[<C-\><C-n>]], { desc = "Exit terminal mode to normal mode" })
vim.keymap.set("t", "<Esc>", "<Esc>", { desc = "Disable Esc in terminal mode" })
