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
    'hrsh7th/cmp-nvim-lsp',
    "hrsh7th/cmp-nvim-lsp-signature-help",
    'hrsh7th/cmp-path',
    "hrsh7th/nvim-cmp",
    "neovim/nvim-lspconfig",
    "lewis6991/gitsigns.nvim",
    "Tetralux/odin.vim",
    {"echasnovski/mini.pick", version = '*' },
    { 'echasnovski/mini.cursorword', version = '*' },
    {"nvim-treesitter/nvim-treesitter", branch = 'master', lazy = false, build = ":TSUpdate"},
    {
        'NTBBloodbath/doom-one.nvim',
        config = function()
            -- Add color to cursor
            vim.g.doom_one_cursor_coloring = false
            -- Set :terminal colors
            vim.g.doom_one_terminal_colors = true
            -- Enable italic comments
            vim.g.doom_one_italic_comments = true
            -- Enable TS support
            vim.g.doom_one_enable_treesitter = true
            -- Color whole diagnostic text or only underline
            vim.g.doom_one_diagnostics_text_color = false
            -- Enable transparent background
            vim.g.doom_one_transparent_background = false

            -- Pumblend transparency
            vim.g.doom_one_pumblend_enable = false
            vim.g.doom_one_pumblend_transparency = 20

            -- Plugins integration
            vim.g.doom_one_plugin_neorg = false
            vim.g.doom_one_plugin_barbar = false
            vim.g.doom_one_plugin_telescope = false
            vim.g.doom_one_plugin_neogit = false
            vim.g.doom_one_plugin_nvim_tree = false
            vim.g.doom_one_plugin_dashboard = false
            vim.g.doom_one_plugin_startify = false
            vim.g.doom_one_plugin_whichkey = false
            vim.g.doom_one_plugin_indent_blankline = false
            vim.g.doom_one_plugin_vim_illuminate = false
            vim.g.doom_one_plugin_lspsaga = false
        end
    }
})
require'nvim-treesitter.configs'.setup {ensure_installed = { "c", "lua", "vim", "vimdoc", "query", "markdown", "markdown_inline" },
    highlight = {enable = true}}

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
        mapping = cmp.mapping.preset.insert({
            ['<C-b>'] = cmp.mapping.scroll_docs(-4),
            ['<C-f>'] = cmp.mapping.scroll_docs(4),
            ['<C-Space>'] = cmp.mapping.complete(),
            ['<C-e>'] = cmp.mapping.abort(),
        }),
})


vim.opt.pumheight = 5
vim.opt.pumwidth = 20
vim.opt.spell = true
vim.opt.spelllang = { "en_us" }

vim.opt.termguicolors = true
vim.o.background = "dark"
vim.cmd.colorscheme("doom-one")

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
vim.keymap.set("n", "<leader>ff", "<CMD>Pick files<CR>")
vim.keymap.set("n", "<leader>fg", "<CMD>Pick grep_live<CR>")

require('mini.cursorword').setup()

vim.lsp.enable('pyright')
vim.lsp.enable('clangd')
vim.diagnostic.config({ underline = false, virtual_lines = false, signs = true, severity_sort=true})
vim.keymap.set("n", "<leader>e", function()
vim.diagnostic.open_float(nil, { focus = false, border = "rounded" }, { desc = ''})
end, { desc = "Show diagnostics in floating window" })
