"pickperf--- Basic settings ---
set tabstop=4            " Number of visual spaces per tab
set softtabstop=4        " Number of spaces in tab when editing
set shiftwidth=4         " Number of spaces used for autoindent
set expandtab            " Convert tabs to spaces
set number               " Show line numbers
set relativenumber       " Show line relative line numbers
set splitbelow           " Horizontal split opens at the bottom
set splitright           " Vertical split opens to the right
set nowrap               " Do not wrap long lines
set backspace=indent,eol,start
set history=1000
set shortmess+=c   " Shut off completion messages

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
set termguicolors
set t_Co=256
set background=dark
" colorscheme mck
autocmd ColorScheme * hi Normal ctermbg=NONE
autocmd ColorScheme * hi NonText ctermbg=NONE
autocmd ColorScheme * hi EndOfBuffer ctermbg=NONE
autocmd ColorScheme * hi clear Statement
autocmd ColorScheme * hi clear Statement
autocmd ColorScheme * hi clear Preproc
autocmd ColorScheme * hi clear Type
autocmd ColorScheme * hi clear Special
autocmd ColorScheme * hi clear Constant
colorscheme torte
syntax on
set exrc
set secure
set timeout
set ttimeout
set timeoutlen=500
set ttimeoutlen=10

nnoremap <F10> :echo "hi<" . synIDattr(synID(line("."),col("."),1),"name") . '> trans<'
\ . synIDattr(synID(line("."),col("."),0),"name") . "> lo<"
\ . synIDattr(synIDtrans(synID(line("."),col("."),1)),"name") . ">"<CR>

