"--- Basic settings ---
set tabstop=4            " Number of visual spaces per tab
set softtabstop=4        " Number of spaces in tab when editing
set shiftwidth=4         " Number of spaces used for autoindent
set smarttab
set autoindent
set smartindent
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
set showmode
set wildmenu
set statusline=                       " Start with an empty status line
set statusline+=\ %F\ %M\ %Y\ %R      " Show file name, modified flag, file type, and readonly flag
set statusline+=%=                    " Separate left and right sections
set statusline+=\ row:\ %l\ col:\ %c\ percent:\ %p%% " Show current row, column, and percent through file
set laststatus=2                      " Always display the status line

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
" colorscheme vacme

" set cursorline

set mouse+=a
set autoread

call plug#begin('~/.vim/plugged')
Plug 'tikhomirov/vim-glsl'
Plug 'vale1410/vim-minizinc'
Plug 'jpalardy/vim-slime'
Plug 'prabirshrestha/vim-lsp'
Plug 'prabirshrestha/asyncomplete.vim'
Plug 'prabirshrestha/asyncomplete-lsp.vim'
Plug 'prabirshrestha/asyncomplete-buffer.vim'
Plug 'prabirshrestha/asyncomplete-file.vim'
Plug 'mattn/vim-lsp-settings'
call plug#end()

autocmd! BufNewFile,BufRead *.vs,*.fs set ft=glsl
packadd! termdebug

let g:slime_target = "tmux"
let g:slime_default_config = {
\ "socket_name": "default",
\ "target_pane": "{right-of}"
\ }

function! s:on_lsp_buffer_enabled() abort
    setlocal omnifunc=lsp#complete
    setlocal signcolumn=yes
    if exists('+tagfunc') | setlocal tagfunc=lsp#tagfunc | endif
    nmap <buffer> gd <plug>(lsp-definition)
    nmap <buffer> gs <plug>(lsp-document-symbol-search)
    nmap <buffer> gS <plug>(lsp-workspace-symbol-search)
    nmap <buffer> gr <plug>(lsp-references)
    nmap <buffer> gi <plug>(lsp-implementation)
    nmap <buffer> gt <plug>(lsp-type-definition)
    nmap <buffer> <leader>rn <plug>(lsp-rename)
    nmap <buffer> [g <plug>(lsp-previous-diagnostic)
    nmap <buffer> ]g <plug>(lsp-next-diagnostic)
    nmap <buffer> K <plug>(lsp-hover)
    nnoremap <buffer> <expr><c-f> lsp#scroll(+4)
    nnoremap <buffer> <expr><c-d> lsp#scroll(-4)

    let g:lsp_format_sync_timeout = 1000
    autocmd! BufWritePre *.rs,*.go call execute('LspDocumentFormatSync')

    " refer to doc to add more commands
endfunction

augroup lsp_install
    au!
    " call s:on_lsp_buffer_enabled only for languages that has the server registered.
    autocmd User lsp_buffer_enabled call s:on_lsp_buffer_enabled()
augroup END
