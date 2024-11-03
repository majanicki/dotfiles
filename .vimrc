set number 
set path+=** " search into subfolders
set wildmenu
filetype plugin indent on
syntax on
set backspace=indent,eol,start
set hidden
set noswapfile
set shiftwidth=2 tabstop=2 softtabstop=2 autoindent smartindent expandtab
set relativenumber
set hlsearch
set incsearch
set nocompatible
set ignorecase
set smartcase
if $COLORTERM == 'gnome-terminal'
    set t_Co=256
endif
set ruler
set laststatus=2
colorscheme PaperColor
set nocompatible
