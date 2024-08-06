-- Create an event handler for the FileType autocommand
vim.api.nvim_create_autocmd('FileType', {
  -- This handler will fire when the buffer's 'filetype' is "c"
  pattern = 'c',
  callback = function(args)
    vim.lsp.start({
      name = 'clangd',
      cmd = {'clangd', '--function-arg-placeholders=0', '--fallback-style=Google', '--clang-tidy'},
    })
  end,
})
