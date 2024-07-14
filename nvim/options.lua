local opt = vim.opt
opt.number = true
opt.relativenumber = true
opt.tabstop = 4
opt.shiftwidth = 2
-- opt.expandtab = true
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

function Colorscheme(color)
	color = color or "catppuccin-frappe"
	vim.cmd.colorscheme(color)

	vim.api.nvim_set_hl(0, "Normal", { bg = "none" })
	vim.api.nvim_set_hl(0, "NormalFloat", { bg = "none" })
end

-- Colorscheme()
--
--

-- The setup config table shows all available config options with their default values:
-- require("neocord").setup({})
