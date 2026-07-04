"--- Basic settings ---
set tabstop=4            " Number of visual spaces per tab
set softtabstop=4        " Number of spaces in tab when editing
set shiftwidth=4         " Number of spaces used for autoindent
set expandtab            " Convert tabs to spaces
set number               " Show line numbers
set relativenumber       " Show line numbers
set splitbelow           " Horizontal split opens at the bottom
set splitright           " Vertical split opens to the right
set nowrap               " Do not wrap long lines
set backspace=indent,eol,start
set history=1000
set shortmess+=c   " Shut off completion messages
set completeopt=menu,menuone,noselect,noinsert
set noshowmode
let mapleader = " "

" Return to last edit position when opening files (You want this!)
autocmd BufReadPost *
     \ if line("'\"") > 0 && line("'\"") <= line("$") |
     \   exe "normal! g`\"" |
     \ endif

" Enable syntax highlighting
syntax enable

" Enable file type detection and plugin loading
filetype plugin indent on

" Auto detect file types (may already be on by default)
filetype on

" --- Search settings ---
set incsearch            " Incremental search
set ignorecase           " Ignore case when searching...
set smartcase            " ...unless the search includes uppercase

" Highlight the current line

" --- Show trailing whitespace and tabs ---
set list
set listchars=trail:·,tab:»\ 

" --- Disable annoying sounds (bells) ---
set belloff=all

set t_Co=256
set termguicolors
set background=dark
" autocmd vimenter * ++nested colorscheme gruvbox
"" colorscheme vacme
colorscheme PaperColor

" set cursorline

set mouse+=a
set autoread

call plug#begin('~/.vim/plugged')
Plug 'tikhomirov/vim-glsl'
Plug 'vale1410/vim-minizinc'
Plug 'jpalardy/vim-slime'
Plug 'tpope/vim-dispatch'
Plug 'girishji/vimcomplete'
Plug 'yegappan/lsp'
call plug#end()

let lspOpts = (#{
        \   autoHighlightDiags: v:false,
        \   diagSignErrorText: 'E',
        \   echoSignature: v:true,
        \   highlightDiagInline: v:false,
        \   semanticHighlight: v:false,
        \   showSignature: v:true,
        \   showSignatureDocs: v:false,
	\ })
autocmd User LspSetup call LspOptionsSet(lspOpts)

let lspServers = [#{
	\	  name: 'clang',
	\	  filetype: ['c', 'cpp'],
	\	  path: '/usr/bin/clangd',
	\	  args: ['--background-index']
	\ }]
autocmd User LspSetup call LspAddServer(lspServers)

nmap gd          :LspGotoDefinition<CR>
nmap gr          :LspShowReferences<CR>
nmap gri         :LspGotoImpl<CR>
nmap <leader>rn  :LspRename<CR>
nmap K           :LspHover<CR>
nmap [d          :LspDiag prev<CR>
nmap ]d          :LspDiag next<CR>
nmap <space>e    :LspDiagHere <CR>
set signcolumn=number

" let vcoptions = {
"     \ 'completor': {'showCmpSource': 0},
"     \ 'lsp': {'cmpSourceWidth': 3},
"     \ }
" autocmd VimEnter * call g:VimCompleteOptionsSet(vcoptions)



autocmd! BufNewFile,BufRead *.vs,*.fs set ft=glsl
packadd! termdebug

let g:slime_target = "tmux"
let g:slime_default_config = {
\ "socket_name": "default",
\ "target_pane": "{right-of}"
\ }

