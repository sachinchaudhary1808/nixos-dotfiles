vim.api.nvim_create_augroup("TermOpen", { clear = true })
vim.api.nvim_create_autocmd({ "TermOpen" }, { command = "startinsert", group = "TermOpen" })
