vim.opt.clipboard = "unnamedplus" -- use system clipboard
vim.opt.completeopt = {"menu", "menuone", "noselect"} -- show menu with completions


vim.opt.tabstop = 2       -- Number of visual spaces per tab
vim.opt.softtabstop = 2   -- Number of spaces in tab when editting
vim.opt.shiftwidth = 2    -- Number of spaces in tab
vim.opt.expandtab = true

vim.opt.number = true     -- show line numbers
vim.opt.relativenumber = true
vim.opt.cursorline = true -- highlight line under cursor
vim.opt.splitbelow = true -- horizontal split opens at a bottom
vim.opt.splitright = true -- vertical split opens at the right
vim.opt.showmode = false  -- Don't show insert at the bottom

vim.opt.incsearch = true  -- search as characters are entered
vim.opt.hlsearch = true   -- highlight search
vim.opt.ignorecase = true
vim.opt.smartcase = true  -- do not ignore uppercase

vim.opt.listchars:append{trail="·",tab=">>",nbsp="·"}
vim.opt.list = true

