local lspconfig = require("lspconfig")

local capabilities = {
    textDocument = {
        foldingRange = {
            dynamicRegistration = false,
            lineFoldingOnly = true,
        },
    },
}

-- Set lsp capabilities globally
vim.lsp.config("*", {
    capabilities = require("blink.cmp").get_lsp_capabilities(capabilities),
})

-- Setup each LSP server individually
vim.lsp.config("gopls", {
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

vim.lsp.enable("gopls")

vim.lsp.enable("lua_ls")
require("lazydev").setup({
    library = { { path = "${3rd}/luv/library", words = { "vim%.uv" } } },
})

vim.lsp.enable("nil_ls")
vim.lsp.enable("marksman")
vim.lsp.enable("rust_analyzer")
vim.lsp.enable("yamlls")
vim.lsp.enable("bashls")
vim.lsp.enable("clangd")

-- Optional: Setup lsp-saga for enhanced LSP UI
require("lspsaga").setup({})

-- lsp inline hint
-- vim.diagnostic.config({ virtual_text = true })
--
vim.lsp.enable("html")
vim.lsp.enable("cssls")
vim.lsp.enable("jsonls")
vim.lsp.enable("eslint")

-- python lsp server
vim.lsp.enable("pyright")
