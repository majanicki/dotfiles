-- general options
vim.o.completeopt = "menu,menuone,popup,fuzzy" -- modern completion menu

-- NOTE: Setting vim options can be opinionated.
-- While options above are crucial to make this whole config work as expected,
-- below are just list of options I think most users will satisfy.
-- Feel free to modify as your preference.


vim.o.termguicolors = true  -- enable rgb colors

vim.o.cursorline = true     -- enable cursor line

vim.o.number = true         -- enable line number
vim.o.relativenumber = true -- and relative line number

vim.o.signcolumn = "yes"    -- always show sign column

vim.o.pumheight = 10        -- max height of completion menu

vim.o.list = true           -- use special characters to represent things like tabs or trailing spaces
vim.opt.listchars = {       -- NOTE: using `vim.opt` instead of `vim.o` to pass rich object
	tab = "» ",
	trail = "·",
}

vim.opt.diffopt:append("linematch:60") -- second stage diff to align lines

vim.o.confirm = true     -- show dialog for unsaved file(s) before quit
vim.o.updatetime = 200   -- save swap file with 200ms debouncing

vim.o.ignorecase = true  -- case-insensitive search
vim.o.smartcase = true   -- , until search pattern contains upper case characters

vim.o.smartindent = true -- auto-indenting when starting a new line
vim.o.shiftround = true  -- round indent to multiple of 'shiftwidth'
vim.o.shiftwidth = 0     -- 0 to follow the 'tabstop' value
vim.o.tabstop = 4        -- tab width
vim.o.expandtab = true

vim.o.undofile = true    -- enable persistent undo
vim.o.undolevels = 10000 -- 10x more undo levels


-- define <leader> and <localleader> keys
-- you should use `vim.keycode` to translate keycodes or pass raw keycode values like `" "` instead of just `"<space>"`
vim.g.mapleader = vim.keycode("<space>")
vim.g.maplocalleader = vim.keycode("<cr>")

-- remove netrw banner for cleaner looking
vim.g.netrw_banner = 0

-- :h lsp-config

-- enable lsp completion
vim.api.nvim_create_autocmd("LspAttach", {
	group = vim.api.nvim_create_augroup("UserLspAttach", { clear = true }),
	callback = function(ev)
		local buf = ev.buf
		local map = function(k, f) vim.keymap.set("n", k, f, { buffer = buf }) end

		map("gd",        vim.lsp.buf.definition)
		map("gD",        vim.lsp.buf.declaration)
		map("grr",       vim.lsp.buf.references)       -- 0.11 default
		map("gri",       vim.lsp.buf.implementation)   -- 0.11 default
		map("K",         vim.lsp.buf.hover)
		map("<leader>r", vim.lsp.buf.rename)
		map("<leader>a", vim.lsp.buf.code_action)
		map("<leader>f", vim.lsp.buf.format)

		local client = vim.lsp.get_client_by_id(ev.data.client_id)
		client.server_capabilities.semanticTokensProvider = nil
	end,
})

vim.diagnostic.config({
	virtual_text = false,
	update_in_insert = false,
	signs = {true, severity = { min = vim.diagnostic.severity.ERROR } },
	underline =false,
	float = {
		border = "rounded",
		source = true,
	},
})

-- Show diagnostics under cursor manually
vim.keymap.set("n", "<leader>e", vim.diagnostic.open_float)
vim.keymap.set("n", "[d",        vim.diagnostic.goto_prev)
vim.keymap.set("n", "]d",        vim.diagnostic.goto_next)

-- enable configured language servers
-- you can find server configurations from lsp/*.lua files
vim.lsp.enable('clangd')
vim.lsp.enable('basedpyright')

vim.cmd.colorscheme('PaperColor')
