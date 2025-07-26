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
    'stevearc/oil.nvim',
    "neovim/nvim-lspconfig",
    'hrsh7th/cmp-buffer',
    'hrsh7th/cmp-path',
    'hrsh7th/cmp-cmdline',
    'hrsh7th/cmp-nvim-lsp',
    "hrsh7th/cmp-nvim-lsp-signature-help",
    "hrsh7th/nvim-cmp",
    "lewis6991/gitsigns.nvim",
    "Tetralux/odin.vim",
    -- init.lua:
    {
        'nvim-telescope/telescope.nvim', tag = '0.1.8',
        -- or                              , branch = '0.1.x',
        dependencies = { 'nvim-lua/plenary.nvim' }
    },
    {
        "ThePrimeagen/harpoon",
        branch = "harpoon2", -- or omit if you want v1
    },
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
            { name = 'nvim_lsp_signature_help' },
            { name = 'nvim_lsp' },
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
vim.o.background = "dark"
vim.cmd.colorscheme("PaperColor")
vim.lsp.enable('pyright')
-- vim.lsp.enable('clangd')
vim.lsp.enable('gopls')
vim.lsp.enable('ols')

vim.diagnostic.config({ underline = true, virtual_lines = false, signs = true, severity_sort=true})
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
vim.keymap.set("n", "<leader>e", function()
    vim.diagnostic.open_float(nil, { focus = false, border = "rounded" }, { desc = ''})
end, { desc = "Show diagnostics in floating window" })
vim.keymap.set('n', '<F2>', vim.lsp.buf.rename, { desc = 'LSP Rename' })


local telescope = require('telescope.builtin')
vim.keymap.set('n', '<leader>ff', telescope.find_files, { desc = 'Telescope find files' })
vim.keymap.set('n', '<leader>fg', telescope.live_grep, { desc = 'Telescope live grep' })
vim.keymap.set('n', '<leader>fb', telescope.buffers, { desc = 'Telescope buffers' })
vim.keymap.set('n', '<leader>fm', telescope.marks, { desc = 'Telescope marks' })
vim.keymap.set('n', '<leader>fd', telescope.lsp_document_symbols, { desc = 'Telescope lsp document symbols' })

local harpoon = require("harpoon")

harpoon:setup({})

vim.keymap.set("n", "<leader>m", function() harpoon:list():add() end)
vim.keymap.set("n", "<leader>'", function() harpoon.ui:toggle_quick_menu(harpoon:list()) end)
vim.keymap.set("n", "<leader>1", function() harpoon:list():select(1) end)
vim.keymap.set("n", "<leader>2", function() harpoon:list():select(2) end)
vim.keymap.set("n", "<leader>3", function() harpoon:list():select(3) end)
vim.keymap.set("n", "<leader>4", function() harpoon:list():select(4) end)

vim.o.guifont = "Consolas:h15"
-- require'nvim-treesitter.configs'.setup {highlight = {enable = true}}
require("oil").setup()
