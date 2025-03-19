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

-- for startuptime
vim.loader.enable()
