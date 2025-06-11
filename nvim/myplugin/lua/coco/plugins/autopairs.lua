local autopairs = require("nvim-autopairs")

-- configure autopairs
autopairs.setup({
    check_ts = true,                  -- enable treesitter
    ts_config = {
        lua = { "string" },           -- don't add pairs in lua string treesitter nodes
        javascript = { "template_string" }, -- don't add pairs in javscript template_string treesitter nodes
        java = false,                 -- don't check treesitter on java
    },
})

-- import nvim-autopairs completion functionality
local cmp_autopairs = require("nvim-autopairs.completion.cmp")

-- import nvim-cmp plugin (completions plugin)
local cmp = require("cmp")

-- make autopairs and completion work together
cmp.event:on("confirm_done", cmp_autopairs.on_confirm_done())

require("nvim-ts-autotag").setup({
    opts = {
        -- Defaults
        enable_close = true,     -- Auto close tags
        enable_rename = true,    -- Auto rename pairs of tags
        enable_close_on_slash = false, -- Auto close on trailing </
    },
    -- Also override individual filetype configs, these take priority.
    -- Empty by default, useful if one of the "opts" global settings
    -- doesn't work well in a specific filetype
    -- per_filetype = {
    --     ["html"] = {
    --         enable_close = false,
    --     },
    -- },
})
