-- Basic settings
vim.opt.tabstop = 4
vim.opt.softtabstop = 4
vim.opt.shiftwidth = 4
vim.opt.expandtab = true
vim.opt.number = true
vim.opt.splitbelow = true
vim.opt.splitright = true
vim.opt.wrap = false
vim.opt.backspace = { "indent", "eol", "start" }
vim.opt.history = 1000
vim.opt.shortmess:append("c")
vim.opt.cursorline = true
vim.opt.mouse:append("a")
vim.opt.signcolumn = "number"
vim.opt.scrolloff = 5

-- Trailing whitespace and tabs
vim.opt.list = true
vim.opt.listchars = { trail = "·", tab = "» " }

-- Search settings
vim.opt.incsearch = true
vim.opt.ignorecase = true
vim.opt.smartcase = true

vim.g.mapleader = " "


-- Bell
vim.opt.belloff = "all"



local lazypath = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"
if not (vim.uv or vim.loop).fs_stat(lazypath) then
    vim.fn.system({
        "git",
        "clone",
        "--filter=blob:none",
        "https://github.com/folke/lazy.nvim.git",
        "--branch=stable", -- latest stable release
        lazypath,
    })
end
vim.opt.rtp:prepend(lazypath)

require("lazy").setup({
    "NLKNguyen/papercolor-theme",
    {'stevearc/oil.nvim'},
    'hrsh7th/cmp-buffer',
    'hrsh7th/cmp-path',
    "hrsh7th/nvim-cmp",
    "lewis6991/gitsigns.nvim",
    "Tetralux/odin.vim",
    {"echasnovski/mini.pick", version = '*' },
    { 'echasnovski/mini.cursorword', version = '*' },
    {"nvim-treesitter/nvim-treesitter", branch = 'master', lazy = false, build = ":TSUpdate"}

})

cmp = require'cmp'
require("cmp").setup({
    completion = {
        completeopt = 'menu,menuone,noinsert,noselect'
    },
    preselect = cmp.PreselectMode.None,  -- Do NOT preselect automatically
    sources = cmp.config.sources(
        {
            { name = 'buffer' },
            { name = 'path' },
        }),
            mapping = cmp.mapping.preset.insert({
            ['<C-b>'] = cmp.mapping.scroll_docs(-4),
            ['<C-f>'] = cmp.mapping.scroll_docs(4),
            ['<C-Space>'] = cmp.mapping.complete(),
            ['<C-e>'] = cmp.mapping.abort(),
        }),
    })


vim.opt.pumheight = 5
vim.opt.pumwidth = 20


vim.opt.termguicolors = true
vim.o.background = "light"
vim.cmd.colorscheme("PaperColor")

require('gitsigns').setup {
    signs = {
        add          = { text = '+' },
        change       = { text = '~' },
        delete       = { text = '-' },
        topdelete    = { text = '^' },
        changedelete = { text = '*' },
        untracked    = { text = '.' },
    },
    signs_staged_enable = false,
}

vim.o.guifont = "Consolas:h12"

require('oil').setup()
vim.keymap.set("n", "-", "<CMD>Oil<CR>", { desc = "Open parent directory" })

require('mini.pick').setup()
vim.keymap.set("n", "<leader>f", "<CMD>Pick files<CR>")
vim.keymap.set("n", "<leader>g", "<CMD>Pick grep_live<CR>")

require('mini.cursorword').setup()
