local lspconfig = require("lspconfig")

local capabilities = {
    textDocument = {
        foldingRange = {
            dynamicRegistration = false,
            lineFoldingOnly = true,
        },
    },
}

capabilities = require("blink.cmp").get_lsp_capabilities(capabilities)

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
vim.lsp.enable("pylsp")
