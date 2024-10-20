require('mason').setup({
  ui = {
    icons = {
      package_installed = "✓",
      package_pending = "➜",
      package_uninstalled = "✗"
    }
  }
})

-- Set different settings for different languages' LSP
-- LSP list: https://github.com/neovim/nvim-lspconfig/blob/master/doc/server_configurations.md
-- How to use setup({}): https://github.com/neovim/nvim-lspconfig/wiki/Understanding-setup-%7B%7D
--     - the settings table is sent to the LSP
--     - on_attach: a lua callback function to run after LSP attaches to a given buffer local lspconfig = require('lspconfig')

-- Customized on_attach function
-- See `:help vim.diagnostic.*` for documentation on any of the below functions
local opts = { noremap = true, silent = true }
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

-- Use an on_attach function to only map the following keys
-- after the language server attaches to the current buffer
local on_attach = function(client, bufnr)

  -- Enable completion triggered by <c-x><c-o>
  vim.api.nvim_buf_set_option(bufnr, 'omnifunc', 'v:lua.vim.lsp.omnifunc')

  -- See `:help vim.lsp.*` for documentation on any of the below functions
  local bufopts = { noremap = true, silent = true, buffer = bufnr }
  vim.keymap.set('n', 'gD', vim.lsp.buf.declaration, bufopts)
  vim.keymap.set('n', 'gd', vim.lsp.buf.definition, bufopts)
  vim.keymap.set('n', 'gi', vim.lsp.buf.implementation, bufopts)
  vim.keymap.set('n', '<F2>', vim.lsp.buf.rename, bufopts)
  vim.keymap.set('n', '<space>ca', vim.lsp.buf.code_action, bufopts)
  vim.keymap.set('n', 'gr', vim.lsp.buf.references, bufopts)
  vim.keymap.set("n", "<F3>", function()
    vim.api.nvim_set_keymap('n', '<leader>e', '<cmd>lua vim.diagnostic.open_float()<CR>', { noremap = true, silent = true })
    vim.lsp.buf.format({ async = true })
  end, bufopts)
end

-- Configure each language
-- How to add LSP for a specific language?
-- 1. use `:Mason` to install corresponding LSP
-- 2. add configuration below
lspconfig.pylsp.setup({
  on_attach = on_attach,
  settings = {
    pylsp = {
      plugins = {
        jedi_completion = { enabled = true },
        jedi_signature = { enabled = true }, -- Enable signature help
        rope_completion = { enabled = true },
        flake8 = { enabled = true },
        pyflakes = { enabled = true },
        pycodestyle = { enabled = false },
        pydocstyle = { enabled = false },
        mypy = {enabled = true}
      },
    },
  },
})
lspconfig.clangd.setup({
  on_attach = on_attach,
})
vim.api.nvim_set_keymap('n', '<C-n>', '<cmd>lua vim.lsp.buf.document_symbol()<CR>', { noremap = true, silent = true })
