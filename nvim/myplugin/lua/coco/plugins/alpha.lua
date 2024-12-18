local alpha = require("alpha")
local dashboard = require("alpha.themes.dashboard")

-- Set header
dashboard.section.header.val = {
    "                                     ",
    "                                     ",
    "  ▄████▄   ▒█████   ▄████▄   ▒█████  ",
    " ▒██▀ ▀█  ▒██▒  ██▒▒██▀ ▀█  ▒██▒  ██▒",
    " ▒▓█    ▄ ▒██░  ██▒▒▓█    ▄ ▒██░  ██▒",
    " ▒▓▓▄ ▄██▒▒██   ██░▒▓▓▄ ▄██▒▒██   ██░",
    " ▒ ▓███▀ ░░ ████▓▒░▒ ▓███▀ ░░ ████▓▒░",
    " ░ ░▒ ▒  ░░ ▒░▒░▒░ ░ ░▒ ▒  ░░ ▒░▒░▒░ ",
    "   ░  ▒     ░ ▒ ▒░   ░  ▒     ░ ▒ ▒░ ",
    " ░        ░ ░ ░ ▒  ░        ░ ░ ░ ▒  ",
    " ░ ░          ░ ░  ░ ░          ░ ░  ",
    " ░                 ░                 ",
    "                                     ",
    "                                     ",
}

-- Set menu
dashboard.section.buttons.val = {
    dashboard.button("e", "  > New File", "<cmd>ene<CR>"),
    dashboard.button("SPC fe", "  > Toggle file explorer", "<cmd>Ex<CR>"),
    dashboard.button("SPC ff", "󰱼 > Find File", "<cmd>Telescope find_files<CR>"),
    dashboard.button("SPC fg", "  > Find Word", "<cmd>Telescope live_grep<CR>"),
    dashboard.button("SPC fo", "󰁯  > Recent Files", "<cmd>Telescope oldfiles<CR>"),
    dashboard.button("q", " > Quit NVIM", "<cmd>qa<CR>"),
}

local function footer()
    return "𝓗𝓪𝓻 𝓗𝓪𝓻 𝓜𝓪𝓱𝓪𝓭𝓮𝓿"
end

dashboard.section.footer.val = footer()
dashboard.section.footer.opts.hl = "Type"
dashboard.section.header.opts.hl = "Include"
dashboard.section.buttons.opts.hl = "Keyword"

-- Send config to alpha
alpha.setup(dashboard.opts)

-- Disable folding on alpha buffer
vim.cmd([[autocmd FileType alpha setlocal nofoldenable]])
