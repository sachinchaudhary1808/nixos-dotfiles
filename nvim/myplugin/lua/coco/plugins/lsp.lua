local lspconfig = require("lspconfig")

local capabilities = require("cmp_nvim_lsp").default_capabilities()

-- Setup each LSP server individually
lspconfig.gopls.setup({
    capabilities = capabilities,
    settings = {
        gopls = {
            analyses = {
                unusedparams = true,
            },
            staticcheck = true,
            usePlaceholders = true,
            completeUnimported = true,
        },
    },
})

lspconfig.jedi_language_server.setup({ capabilities = capabilities }) -- for python

lspconfig.lua_ls.setup({
    root_dir = function(fname)
        return require("lspconfig.util").root_pattern(".git")(fname) or require("lspconfig.util").path.dirname(fname)
    end,
    single_file_support = true, -- Ensures LSP works for single Lua files outside projects
    settings = {
        Lua = {
            diagnostics = {
                -- Get the language server to recognize the `vim` global
                globals = { "vim" },
            },
        },
    },
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
