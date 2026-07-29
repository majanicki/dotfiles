-- options
vim.o.termguicolors = true
vim.o.cursorline = true
vim.o.number = true
vim.o.relativenumber = true
vim.o.signcolumn = "number"
vim.o.pumheight = 10
vim.o.confirm = true
vim.o.updatetime = 200
vim.o.ignorecase = true
vim.o.smartcase = true
vim.o.smartindent = true
vim.o.shiftround = true
vim.o.shiftwidth = 0
vim.o.tabstop = 4
vim.o.expandtab = true
vim.o.undofile = true
vim.o.undolevels = 10000
vim.o.scrolloff = 3

vim.o.list = true
vim.opt.listchars = { tab = "» ", trail = "·" }
vim.opt.diffopt:append("linematch:60")

vim.g.mapleader = " "
vim.g.maplocalleader = "\r"
vim.g.netrw_banner = 0

-- lazy.nvim bootstrap
local lazypath = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"

if not vim.uv.fs_stat(lazypath) then
    local repo = "https://github.com/folke/lazy.nvim.git"
    local out = vim.fn.system({
        "git",
        "clone",
        "--filter=blob:none",
        "--branch=stable",
        repo,
        lazypath,
    })

    if vim.v.shell_error ~= 0 then
        error("Failed to clone lazy.nvim:\n" .. out)
    end
end

vim.opt.rtp:prepend(lazypath)

require("lazy").setup({
    {
        "nvim-telescope/telescope.nvim",
        dependencies = { "nvim-lua/plenary.nvim" },
        {'tikhomirov/vim-glsl'},
        config = function()
            local builtin = require("telescope.builtin")
            local map = vim.keymap.set

            map("n", "<leader>sf", builtin.find_files, { desc = "Search files" })
            map("n", "<leader>sg", builtin.live_grep, { desc = "Live grep" })
            map("n", "<leader>sw", builtin.grep_string, { desc = "Search word" })
            map("n", "<leader>sh", builtin.help_tags, { desc = "Search help" })
            map("n", "<leader>sk", builtin.keymaps, { desc = "Search keymaps" })
            map("n", "<leader>s.", builtin.oldfiles, { desc = "Recent files" })
            map("n", "<leader><leader>", builtin.buffers, { desc = "Buffers" })

            require("telescope").setup({
                defaults = {
                    mappings = {
                        i = { ["<C-g>"] = require("telescope.actions").close },
                        n = { ["<C-g>"] = require("telescope.actions").close },
                    },
                },
            })
        end,
    },

    {
        "lewis6991/gitsigns.nvim",
        config = function()
            require("gitsigns").setup({
                signs = {
                    add = { text = "+" },
                    change = { text = "~" },
                    delete = { text = "-" },
                    topdelete = { text = "^" },
                    changedelete = { text = "*" },
                    untracked = { text = "." },
                },
                signs_staged_enable = false,
                numhl = true,
            })
        end,
    },
    { 'nvim-mini/mini.completion', version = '*' },
    {'mfussenegger/nvim-dap'},
    {'igorlfs/nvim-dap-view'},
})

-- lsp
vim.api.nvim_create_autocmd("LspAttach", {
    group = vim.api.nvim_create_augroup("UserLspAttach", { clear = true }),
    callback = function(ev)
        local buf = ev.buf

        local function map(mode, lhs, rhs, desc)
            vim.keymap.set(mode, lhs, rhs, { buffer = buf, desc = desc })
        end

        map("n", "gd", vim.lsp.buf.definition, "Definition")
        map("n", "gD", vim.lsp.buf.declaration, "Declaration")
        map("n", "grr", vim.lsp.buf.references, "References")
        map("n", "gri", vim.lsp.buf.implementation, "Implementation")
        vim.keymap.set("n", "K", function()
            -- In termdebug source window, use gdb evaluation hover
            if vim.fn.exists(":Evaluate") == 2 then
                vim.cmd("Evaluate")
                return
            end
            -- Otherwise use LSP hover
            vim.lsp.buf.hover()
        end, { buffer = buf, desc = "Hover / Termdebug Evaluate" })
        map("n", "<leader>r", vim.lsp.buf.rename, "Rename")
        map("n", "<leader>a", vim.lsp.buf.code_action, "Code action")
        map("n", "<leader>f", vim.lsp.buf.format, "Format")

        local client = vim.lsp.get_client_by_id(ev.data.client_id)
        if client then
            client.server_capabilities.semanticTokensProvider = nil
        end
    end,
})

vim.diagnostic.config({
    virtual_text = false,
    update_in_insert = false,
    signs = {
        severity = { min = vim.diagnostic.severity.ERROR },
    },
    underline = false,
    float = {
        border = "rounded",
        source = true,
    },
})

vim.keymap.set("n", "<leader>e", vim.diagnostic.open_float, { desc = "Line diagnostics" })
vim.keymap.set("n", "[d", vim.diagnostic.goto_prev, { desc = "Previous diagnostic" })
vim.keymap.set("n", "]d", vim.diagnostic.goto_next, { desc = "Next diagnostic" })

local capabilities = require('mini.completion').get_lsp_capabilities()
capabilities.textDocument.completion.completionItem.snippetSupport = false
vim.lsp.config('*', {
  capabilities = capabilities,
})

vim.lsp.enable("clangd")
vim.lsp.enable("basedpyright")
vim.cmd.colorscheme("PaperColor")
require('mini.completion').setup()

vim.api.nvim_create_autocmd({ "BufNewFile", "BufRead" }, {
  pattern = { "*.vs", "*.fs" },
  command = "set filetype=glsl",
})


local dap = require("dap")
dap.adapters.gdb = {
  type = "executable",
  command = "gdb",
  args = { "--interpreter=dap", "--eval-command", "set print pretty on" }
}

