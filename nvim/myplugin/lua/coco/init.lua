-- options
-- global option keep this at top
require("coco.options")

-- require("coco.plugins")
require("coco.plugins.alpha")
require("coco.plugins.flash-nvim")
require("coco.plugins.todo-comments")
require("coco.plugins.autopairs")
require("coco.plugins.fugitive")
require("coco.plugins.none-ls")
require("coco.plugins.treesitter")
require("coco.plugins.auto-session")
require("coco.plugins.gitsings")
require("coco.plugins.nvim-tree")
require("coco.plugins.undotree")
require("coco.plugins.bufferline-nvim")
require("coco.plugins.harpoon2")
require("coco.plugins.sniprun")
require("coco.plugins.which-key")
require("coco.plugins.cmp")
require("coco.plugins.lsp")
require("coco.plugins.telescope")
require("coco.plugins.debugging")
require("coco.plugins.vim-test")

require("coco.lua.compiler")
require("coco.snippites.snip")

-- files
require("coco.keymaps")
require("coco.auto-commands")

require("coco.small")
