vim.opt.tabstop = 4       -- Number of visual spaces per tab
vim.opt.softtabstop = 4   -- Number of spaces in tab when editing
vim.opt.shiftwidth = 4    -- Number of spaces in tab
vim.opt.expandtab = true
vim.opt.number = true     -- show line numbers
vim.opt.splitbelow = true -- horizontal split opens at a bottom
vim.opt.splitright = true -- vertical split opens at the right

vim.opt.incsearch = true  -- search as characters are entered
vim.opt.ignorecase = true
vim.opt.smartcase = true  -- do not ignore uppercase

-- show trailing spaces
vim.opt.list = true
vim.opt.listchars:append({ trail = "·", tab = "» " })

vim.o.makeprg = './build.sh'
vim.api.nvim_set_keymap("n", "<F5>", ":make<CR>", { noremap = true, silent = true })

--- vim.opt.spell = true
vim.opt.guicursor = "n-v-c:blinkon1-blinkoff1"

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
    "nvim-treesitter/nvim-treesitter",
    'hrsh7th/cmp-buffer',
    'hrsh7th/cmp-path',
    'hrsh7th/cmp-cmdline',
    "ray-x/cmp-treesitter",
    "hrsh7th/nvim-cmp",
})

require("nvim-treesitter.configs").setup({
  highlight = {enable = false},
  })

cmp = require'cmp'
require("cmp").setup({
    snippet = {
        expand = function(args) 
            vim.snippet.expand(args.body)
        end,
    },
    sources = cmp.config.sources(
      {
        { name = 'treesitter'},
        { name = 'buffer' },
        { name = 'path' },
    }),
    mapping = cmp.mapping.preset.insert({
        ['<C-b>'] = cmp.mapping.scroll_docs(-4),
        ['<C-f>'] = cmp.mapping.scroll_docs(4),
        ['<C-Space>'] = cmp.mapping.complete(),
        ['<C-e>'] = cmp.mapping.abort(),
        ['<CR>'] = cmp.mapping.confirm({ select = true }), -- Accept currently selected item. Set `select` to `false` to only confirm explicitly selected items.
    }),

})

vim.opt.pumheight = 5
vim.opt.pumwidth = 20

vim.o.background = "dark"
vim.opt.termguicolors = true
vim.cmd("colorscheme PaperColor")

