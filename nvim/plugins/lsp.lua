local lspconfig = require("lspconfig")

-- Setup each LSP server individually
lspconfig.pyright.setup({})
lspconfig.lua_ls.setup({})
lspconfig.nil_ls.setup({})
lspconfig.marksman.setup({})
lspconfig.rust_analyzer.setup({})
lspconfig.yamlls.setup({})
lspconfig.bashls.setup({})
lspconfig.clangd.setup({
	cmd = { "clangd", "--offset-encoding=utf-16" }, -- Custom command for clangd
})
lspconfig.emmet_language_server.setup({})
-- Optional: Setup lsp-saga for enhanced LSP UI
require("lspsaga").setup({})
