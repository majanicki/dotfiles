"--- Basic settings ---
set tabstop=4            " Number of visual spaces per tab
set softtabstop=4        " Number of spaces in tab when editing
set shiftwidth=4         " Number of spaces used for autoindent
set expandtab            " Convert tabs to spaces
set number               " Show line numbers
set splitbelow           " Horizontal split opens at the bottom
set splitright           " Vertical split opens to the right
set nowrap               " Do not wrap long lines
set backspace=indent,eol,start
set history=1000
set shortmess+=c   " Shut off completion messages

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

" --- Set make command for Windows ---
if has('win32') || has('win64')
    set makeprg=.\build.bat
    nnoremap <silent> gD :grep! "<C-R><C-W>" *<CR>
    " Set cursor shape (works in most modern terminals)
    let &t_SI = "\<Esc>[6 q"  " blinking vertical bar in insert mode
    let &t_SR = "\<Esc>[4 q"  " underline in replace mode
    let &t_EI = "\<Esc>[2 q"  " block in normal mode
    let $PATH.=';C:\Program Files\Vim\vim91'
else
    set makeprg=./build.sh
    nnoremap <silent> gD :grep! "<C-R><C-W>" .<CR>
endif

" --- Key mappings ---
nnoremap <silent> <F5> :make<CR>
nnoremap <silent> <F4> :copen<CR><C-w>k:q<CR>
nnoremap <silent> <TAB> :bn<CR>
nnoremap <silent> <S-TAB> :bp<CR>
tnoremap <silent> <Esc> <C-\><C-n>

" --- Disable annoying sounds (bells) ---
set belloff=all

set t_Co=256
set termguicolors
set background=light
" autocmd vimenter * ++nested colorscheme gruvbox
colorscheme PaperColor

set cursorline

set mouse+=a
