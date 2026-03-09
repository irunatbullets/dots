source $VIMRUNTIME/defaults.vim

" Indentation
set expandtab
set tabstop=2
set shiftwidth=2
set softtabstop=2
set autoindent
set smartindent

set number
set relativenumber

set termguicolors

call plug#begin('~/.vim/plugged')
Plug 'ghifarit53/tokyonight-vim'
call plug#end()

colorscheme tokyonight

" Tokyo Night tweaks for comments and line numbers
highlight Comment ctermfg=DarkGrey guifg=#565f89
highlight LineNr guifg=#565f89
