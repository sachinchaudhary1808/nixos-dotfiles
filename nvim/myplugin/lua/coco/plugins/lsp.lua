local lspconfig = require("lspconfig")

-- Setup each LSP server individually
lspconfig.gopls.setup({
    settings = {
        gopls = {
            analyses = {
                unusedparams = true,
            },
            staticcheck = true,
            gofumpt = true,
        },
    },
})
lspconfig.jedi_language_server.setup({}) -- for python
lspconfig.lua_ls.setup({
    root_dir = function(fname)
        return require("lspconfig.util").root_pattern(".git")(fname) or require("lspconfig.util").path.dirname(fname)
    end,
    single_file_support = true, -- Ensures LSP works for single Lua files outside projects
})
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
