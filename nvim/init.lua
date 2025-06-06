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
vim.opt.scl = "number"

-- Trailing whitespace and tabs
vim.opt.list = true
vim.opt.listchars = { trail = "·", tab = "» " }

-- Search settings
vim.opt.incsearch = true
vim.opt.ignorecase = true
vim.opt.smartcase = true


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
    "neovim/nvim-lspconfig",
    'hrsh7th/cmp-buffer',
    'hrsh7th/cmp-path',
    'hrsh7th/cmp-cmdline',
    'hrsh7th/cmp-nvim-lsp',
    "hrsh7th/cmp-nvim-lsp-signature-help",
    "hrsh7th/nvim-cmp",
    "lewis6991/gitsigns.nvim",
    {
  "christoomey/vim-tmux-navigator",
  cmd = {
    "TmuxNavigateLeft",
    "TmuxNavigateDown",
    "TmuxNavigateUp",
    "TmuxNavigateRight",
    "TmuxNavigatePrevious",
    "TmuxNavigatorProcessList",
  },
  keys = {
    { "<c-h>", "<cmd><C-U>TmuxNavigateLeft<cr>" },
    { "<c-j>", "<cmd><C-U>TmuxNavigateDown<cr>" },
    { "<c-k>", "<cmd><C-U>TmuxNavigateUp<cr>" },
    { "<c-l>", "<cmd><C-U>TmuxNavigateRight<cr>" },
    { "<c-\\>", "<cmd><C-U>TmuxNavigatePrevious<cr>" },
  },
}

})

cmp = require'cmp'
require("cmp").setup({
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

-- Theme and color
vim.opt.termguicolors = true
vim.o.background = "light"
vim.cmd.colorscheme("PaperColor")
vim.lsp.enable('pyright')
vim.lsp.config['omnisharp'] = {
 cmd = { "/home/mjan/.omnisharp/OmniSharp", "-z", "--hostPID", "8976", "DotNet:enablePackageRestore=false", "--encoding", "utf-8", "--languageserver" },
 root_markers= {"omnisharp.json", ".sln", ".csproj", "function.json"},
}
-- vim.lsp.enable('omnisharp')
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
