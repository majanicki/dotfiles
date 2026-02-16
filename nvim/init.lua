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
    {
        'nvim-telescope/telescope.nvim', tag = '*',
        dependencies = {
            'nvim-lua/plenary.nvim',
            -- optional but recommended
            { 'nvim-telescope/telescope-fzf-native.nvim', build = 'make' },
        }
    },
    { 'echasnovski/mini.cursorword', version = '*' },
})
-- require'nvim-treesitter.configs'.setup {ensure_installed = { "c", "lua", "vim", "vimdoc", "query", "markdown", "markdown_inline" },
    -- highlight = {enable = true}}

cmp = require'cmp'
require("cmp").setup({
    completion = {
        completeopt = 'menu,menuone,noinsert,noselect'
    },
    preselect = cmp.PreselectMode.None,  -- Do NOT preselect automatically
    sources = cmp.config.sources(
        {
            {
                name = 'buffer',
                option = {
                    get_bufnrs = function()
                        return vim.api.nvim_list_bufs()
                    end
                }
            },
            { name = 'path' },
        }),
})


vim.opt.pumheight = 5
vim.opt.pumwidth = 20

vim.opt.termguicolors = true
vim.o.background = "dark"
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

local builtin = require('telescope.builtin')
vim.keymap.set('n', '<leader>f', builtin.find_files, { desc = 'Telescope find files' })
vim.keymap.set('n', '<leader>g', builtin.live_grep, { desc = 'Telescope live grep' })
require('mini.cursorword').setup()
