local opts ={
  noremap = true, -- non-recursive
  silent = true,  -- do not show message
}



-- Hint: see `:h vim.map.set()`
-- Better window navigation
vim.keymap.set('n', '<C-h>', '<C-w>h', opts)
vim.keymap.set('n', '<C-j>', '<C-w>j', opts)
vim.keymap.set('n', '<C-k>', '<C-w>k', opts)
vim.keymap.set('n', '<C-l>', '<C-w>l', opts)

-- Resize with arrows
-- delta: 1 line
vim.keymap.set('n', '<C-Down>', ':resize -1<CR>', opts)
vim.keymap.set('n', '<C-Up>', ':resize +1<CR>', opts)
vim.keymap.set('n', '<C-Right>', ':vertical resize -1<CR>', opts)
vim.keymap.set('n', '<C-Left>', ':vertical resize +1<CR>', opts)
