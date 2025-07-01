local opt = vim.opt
opt.number = true
opt.relativenumber = true
opt.tabstop = 4
opt.shiftwidth = 4
opt.expandtab = true
opt.autoindent = true
opt.wrap = true
opt.ignorecase = true
opt.smartcase = true
opt.termguicolors = true
opt.background = "dark"
opt.signcolumn = "yes"
opt.mouse = "a"
opt.cursorline = true
opt.backspace = "indent,eol,start"
opt.clipboard:append("unnamedplus")
opt.splitright = true
opt.splitbelow = true
opt.undofile = true
opt.swapfile = false
vim.g.mapleader = " "
vim.g.maplocalleader = ","
opt.scrolloff = 999
opt.virtualedit = "block"
opt.inccommand = "split"
opt.colorcolumn = "80"
opt.updatetime = 300
-- views can only be fully collapsed with the global statusline
vim.opt.laststatus = 3

-- Netrw settings
vim.g.netrw_bufsettings = "noma nomod nu rnu nobl nowrap ro"
-- for startuptime
vim.loader.enable()

-- Enable spell checking only for markdown files
vim.api.nvim_create_autocmd("FileType", {
    pattern = "markdown",
    callback = function()
        vim.opt_local.spell = true
        vim.opt_local.spelllang = "en_us"
    end,
})
