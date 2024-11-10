vim.opt.path:append("**") -- search in subfolders
vim.opt.wildmenu = true -- show menu for completion
vim.opt.completeopt = {"menu"} -- show completion menu

vim.opt.tabstop = 2       -- Number of visual spaces per tab
vim.opt.softtabstop = 2   -- Number of spaces in tab when editting
vim.opt.shiftwidth = 2    -- Number of spaces in tab
vim.opt.expandtab = true

vim.opt.number = true     -- show line numbers
vim.opt.relativenumber = true -- show relative numbers
vim.opt.cursorline = true -- highlight line under cursor
vim.opt.splitbelow = true -- horizontal split opens at a bottom
vim.opt.splitright = true -- vertical split opens at the right

vim.opt.incsearch = true  -- search as characters are entered
vim.opt.hlsearch = true   -- highlight search
vim.opt.ignorecase = true
vim.opt.smartcase = true  -- do not ignore uppercase

-- show trailing spaces
vim.opt.list = true
vim.opt.listchars:append({ trail = "·", tab = "» " })

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
  "neovim/nvim-lspconfig",
  "williamboman/mason.nvim",
  "williamboman/mason-lspconfig.nvim",
  "hrsh7th/nvim-cmp",
  'hrsh7th/cmp-nvim-lsp',
  'hrsh7th/cmp-buffer',
  'hrsh7th/cmp-path',
  'hrsh7th/cmp-cmdline',
  'hrsh7th/nvim-cmp',
})

vim.o.background = "light"
vim.cmd("colorscheme PaperColor")

require('mason').setup()


vim.keymap.set('n', '<space>e', vim.diagnostic.open_float, opts)
local lspconfig = require('lspconfig')
-- Disable warnings
vim.diagnostic.config({
  virtual_text = false,
  signs = true,
  underline =true,
  update_in_insert = false,
  severity_sort = true,
})

local on_attach = function(client, bufnr)


  local bufopts = { noremap = true, silent = true, buffer = bufnr }

  -- Map ctrl+n to trigger LSP completion
  -- vim.keymap.set('i', '<C-n>', vim.lsp.omnifunc, bufopts) -- Add lsp completions to ctrl+n menu
  vim.keymap.set('n', '<S-K>', vim.lsp.buf.hover, bufopts)
  vim.keymap.set('n', 'gD', vim.lsp.buf.declaration, bufopts)
  vim.keymap.set('n', 'gd', vim.lsp.buf.definition, bufopts)
  vim.keymap.set('n', 'gi', vim.lsp.buf.implementation, bufopts)
  vim.keymap.set('n', '<F2>', vim.lsp.buf.rename, bufopts)
  vim.keymap.set('n', '<space>ca', vim.lsp.buf.code_action, bufopts)
  vim.keymap.set('n', 'gr', vim.lsp.buf.references, bufopts)
  -- vim.keymap.set('i', '<C-K>',  vim.lsp.buf.signature_help, bufopts)
end

local cmp = require('cmp')

cmp.setup({
  completion = {max_item_count = 3},
  sources = cmp.config.sources({
    { name = 'nvim_lsp' },
    { name = 'buffer' },
    { name = 'path' },
  }),
  mapping = {
    ['<C-n>'] = cmp.mapping.select_next_item(),
    ['<C-p>'] = cmp.mapping.select_prev_item(),
  },
})

local capabilities = require('cmp_nvim_lsp').default_capabilities()
lspconfig.pylsp.setup({on_attach = on_attach,
capabilities = capabilities})
lspconfig.clangd.setup({on_attach = on_attach,
capabilities = capabilities})

