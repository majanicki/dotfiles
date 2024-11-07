set nocompatible
set number 
set relativenumber
set mouse=a

set path+=** " search into subfolders
set wildmenu
set wildignore=*.docx,*.jpg,*.png,*.gif,*.pdf,*.pyc,*.exe,*.flv,*.img,*.xlsx

set completefunc=syntaxcomplete#Complete
set complete+=k
set completeopt=menu

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

set background=light
if $COLORTERM == 'gnome-terminal'
    set t_Co=256
endif
try
  colorscheme PaperColor
endtry

set laststatus=2
set showcmd

set history=1000
set splitbelow splitright
set undodir=~/.vim/backup
set undofile
set undoreload=10000

inoremap [ []<left>
inoremap ( ()<left>
inoremap { {}<left>
inoremap " ""<left>
inoremap ' ''<left>

set showmatch

set list
set listchars=tab:»·,trail:·,extends:→,precedes:←

