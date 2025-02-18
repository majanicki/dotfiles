set nocompatible
set mouse=a
set number

set path+=** " search into subfolders
set wildmenu

filetype plugin indent on
syntax on

set backspace=indent,eol,start
set hidden
set noswapfile

set smarttab
set shiftwidth=2
set tabstop=2
set expandtab

set hlsearch
set incsearch
set ignorecase
set smartcase

set background=dark
if $COLORTERM == 'gnome-terminal'
    set t_Co=256
endif
try
  colorscheme PaperColor
endtry

set laststatus=2
set showcmd
set showmatch

set history=1000
set splitbelow splitright
set undodir=~/.vim/backup
set undofile
set undoreload=10000

set list
set listchars=tab:»·,trail:·,extends:→,precedes:←

set completeopt+=menuone
set completeopt+=noselect
set shortmess+=c   " Shut off completion messages
set belloff+=ctrlg " Add only if Vim beeps during completion
let g:mucomplete#enable_auto_at_startup = 1

set omnifunc=syntaxcomplete#Complete

let g:mucomplete#chains = {'default' : ['path', 'keyn', 'c-n', 'defs', 'incl', 'dict', 'uspl']}

set makeprg=./build.sh
map <F5> :make<CR>

set showcmd
set cmdheight=1
