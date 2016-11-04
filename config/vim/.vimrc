set ruler
set number
set cursorline
" Set font for vim
set guifont=Inconsolata\ for\ Powerline:h15
let g:airline_powerline_fonts = 1
let g:Powerline_symbols = 'fancy'
set laststatus=2
let g:airline#extensions#tabline#enabled = 1
set encoding=utf-8
set t_Co=256
set fillchars+=stl:\ ,stlnc:\
set term=xterm-256color
set termencoding=utf-8

call pathogen#infect()
syntax on

filetype plugin indent on
syntax enable
" Solarized stuff
let g:solarized_termtrans = 1
let g:solarized_teamcolors = 256
set background=dark
colorscheme solarized
"filetype off        
" set the runtime path to include Vundle and initialize
set rtp+=/usr/local/bin/fzf
" Plugin
call plug#begin('~/.vim/plugged')

Plug 'junegunn/fzf', { 'dir': '~/.fzf', 'do': './install --all' }
Plug 'junegunn/fzf.vim'
Plug 'scrooloose/nerdtree', { 'on':  'NERDTreeToggle' }
Plug 'vim-airline/vim-airline'
Plug 'vim-airline/vim-airline-themes'
Plug 'Valloric/YouCompleteMe', { 'do': './install.py' }
call plug#end()
