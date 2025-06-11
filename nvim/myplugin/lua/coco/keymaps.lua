local keymap = vim.keymap
-- clear search highlights
keymap.set("n", "<leader>nh", ":nohl<CR>", { desc = "Clear search highlights" })
-- window management
keymap.set("n", "<leader>sv", "<C-w>v", { desc = "Split window vertically" })                   -- split window vertically
keymap.set("n", "<leader>sh", "<C-w>s", { desc = "Split window horizontally" })                 -- split window horizontally
keymap.set("n", "<leader>se", "<C-w>=", { desc = "Make splits equal size" })                    -- make split windows equal width & height
keymap.set("n", "<leader>sx", "<cmd>close<CR>", { desc = "Close current split" })               -- close current split window
vim.keymap.set("n", "<leader>so", ":only<CR>", { noremap = true, silent = true })
keymap.set("n", "<leader>to", "<cmd>tabnew<CR>", { desc = "Open new tab" })                     -- open new tab
keymap.set("n", "<leader>tx", "<cmd>tabclose<CR>", { desc = "Close current tab" })              -- close current tab
keymap.set("n", "<leader>tn", "<cmd>tabn<CR>", { desc = "Go to next tab" })                     --  go to next tab
keymap.set("n", "<leader>tp", "<cmd>tabp<CR>", { desc = "Go to previous tab" })                 --  go to previous tab
keymap.set("n", "<leader>tf", "<cmd>tabnew %<CR>", { desc = "Open current buffer in new tab" }) --  move current buffer to new tab
keymap.set("n", "<leader>=", "<cmd>Neoformat<CR>", { desc = "manual formatting" })              --  manual code formatting

-- file-tree
keymap.set("n", "<leader>fe", "<cmd>Ex<CR>", { desc = "netrw" })

-- visual mode
vim.keymap.set("v", "J", ":m '>+1<CR>gv=gv")
vim.keymap.set("v", "K", ":m '<-2<CR>gv=gv")

-- scroll
vim.keymap.set("n", "<C-d>", "<C-d>zz")
vim.keymap.set("n", "<C-u>", "<C-u>zz")

-- something cool
vim.keymap.set("x", "<leader>p", '"_dp')

-- LSP keybindings
vim.keymap.set("n", "gd", vim.lsp.buf.definition)
-- vim.keymap.set("n", "K", vim.lsp.buf.hover) -- i guess neovim sets this by default
vim.keymap.set("n", "<leader>rn", vim.lsp.buf.rename)
vim.keymap.set("n", "<leader>ca", vim.lsp.buf.code_action)
vim.keymap.set("n", "gr", vim.lsp.buf.references)
vim.keymap.set("n", "<leader>cd", function()
    vim.diagnostic.open_float({ border = "rounded" })
end, { desc = "Goto Error" })

-- tmux
vim.g.tmux_navigator_no_mappings = 1
vim.keymap.set("n", "<C-h>", "<cmd>TmuxNavigateLeft<cr>", { silent = true })
vim.keymap.set("n", "<C-j>", "<cmd>TmuxNavigateDown<cr>", { silent = true })
vim.keymap.set("n", "<C-k>", "<cmd>TmuxNavigateUp<cr>", { silent = true })
vim.keymap.set("n", "<C-l>", "<cmd>TmuxNavigateRight<cr>", { silent = true })
vim.keymap.set("n", "<C-\\>", "<cmd>TmuxNavigatePrevious<cr>", { silent = true })

vim.api.nvim_create_user_command("LivePreview", function()
    local file = vim.fn.expand("%:t") -- just the filename, like 'buttons.html'
    local dir = vim.fn.expand("%:p:h") -- directory of current file

    vim.fn.jobstart({ "live-server", "--open=" .. file }, {
        cwd = dir,
        detach = true,
    })
end, {})

vim.keymap.set("n", "<leader>ls", ":LivePreview<CR>", { desc = "Live Server Preview" })

-- write the file
vim.keymap.set("n", "<leader>e", ":write<CR>", { desc = "save the changes in the file" })
