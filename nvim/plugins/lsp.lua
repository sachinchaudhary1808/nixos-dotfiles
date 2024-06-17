local lspconfig = require("lspconfig")

require("lspconfig").pyright.setup({})
require("lspconfig").lua_ls.setup({})
require("lspconfig").nil_ls.setup({})
require("lspconfig").marksman.setup({})
require("lspconfig").rust_analyzer.setup({})
require("lspconfig").yamlls.setup({})
require("lspconfig").bashls.setup({})
require("lspconfig").clangd.setup({ cmd = { "clangd", "--offset-encoding=utf-16" } })

-- Enables logs to debug lspthings
-- vim.lsp.set_log_level("debug")

-- Lsp-saga
require("lspsaga").setup({})
