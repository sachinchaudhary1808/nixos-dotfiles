require("neotest").setup({
    adapters = {
        require("neotest-go"),
    },
    -- This adds more detailed output and diagnostics
    diagnostic = {
        enabled = true,
    },
    -- Highlights for test results
    highlights = {
        passed = "DiagnosticSignOk",
        failed = "DiagnosticSignError",
        running = "DiagnosticSignWarn",
    },
})

vim.keymap.set("n", "<leader>Tt", function()
    require("neotest").run.run()
end, { desc = "Run nearest test" })
vim.keymap.set("n", "<leader>Tf", function()
    require("neotest").run.run(vim.fn.expand("%"))
end, { desc = "Run current test file" })
vim.keymap.set("n", "<leader>To", function()
    require("neotest").output.open({ enter = true })
end, { desc = "Open test output" })
vim.keymap.set("n", "<leader>Ts", function()
    require("neotest").summary.toggle()
end, { desc = "Toggle test summary" })
