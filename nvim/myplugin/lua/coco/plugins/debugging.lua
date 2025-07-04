local dap = require("dap")
local dapui = require("dapui")

dapui.setup()

-- Dapui configuration
dap.listeners.after.event_initialized["dapui_config"] = function()
    dapui.open()
end
dap.listeners.before.event_terminated["dapui_config"] = function()
    dapui.close()
end
dap.listeners.before.event_exited["dapui_config"] = function()
    dapui.close()
end

-- KeyMappings for DAP
vim.keymap.set("n", "<F5>", function()
    require("dap").continue()
end)
vim.keymap.set("n", "<F10>", function()
    require("dap").step_over()
end)
vim.keymap.set("n", "<F11>", function()
    require("dap").step_into()
end)
vim.keymap.set("n", "<F12>", function()
    require("dap").step_out()
end)
vim.keymap.set("n", "<Leader>Db", function()
    require("dap").toggle_breakpoint()
end)
vim.keymap.set("n", "<Leader>Dr", function()
    require("dap").repl.open()
end)

-- For python
require("dap-python").setup("python") -- assumes python in PATH
