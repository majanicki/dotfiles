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
  "Mofiqul/vscode.nvim",
  "williamboman/mason.nvim",
  "williamboman/mason-lspconfig.nvim",
  "neovim/nvim-lspconfig",
  "ray-x/lsp_signature.nvim",
  { 'echasnovski/mini.completion', version = '*' },
  { 'echasnovski/mini.diff', version = '*' },
  { 'echasnovski/mini.statusline', version = '*' },
  { 'echasnovski/mini-git', version = '*' },
  { 'echasnovski/mini.surround', version = '*' },
  "nvim-treesitter/nvim-treesitter",
})

require("mini.completion").setup({info= {border='single'}, signature={border = 'single'}})
vim.opt.pumheight = 5
vim.opt.pumwidth = 18
require("mini.diff").setup({
  view = {
    signs = {add='+', change='~', delete='-'}
  }
})
require("mini.statusline").setup({use_icons = false})
require("mini.git").setup()
require("mini.surround").setup()
require'nvim-treesitter.configs'.setup {
  highlight = {
    enable = true,                  -- false will disable the whole extension
  },
  indent = {
    enable = true,                  -- Enable indentation based on Tree-sitter
  },
}

