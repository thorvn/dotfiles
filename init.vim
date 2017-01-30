" ----- General settings -----
  " base
  set nocompatible                      " vim, not vi
  syntax on                             " syntax highlighting
  filetype plugin indent on             " try to recognise filetype and load plugins and indent files

  " interface
  set background=dark                   " tell vim what the background color looks like
  set colorcolumn=100                   " show a column at 100 chars
  set cursorline                        " highlight current line
  set laststatus=2                      " enable airline on open
  set noshowmode                        " don't show mode as airline already does
  set number                            " show line numbers
  set relativenumber                    " show relative line numbers
  set ruler                             " show current position at bottom
  set scrolloff=5                       " keep at least 5 lines above/below
  set shortmess+=I                      " disable welcome screen
  set showcmd                           " show any commands
  set sidescroll=1                      " smoother horizontal scrolling
  set sidescrolloff=5                   " keep at least 5 lines left/right
  set splitbelow                        " create new splits below
  set splitright                        " create new splits to the right
  set termguicolors                     " enable true colors
  set wildmenu                          " enable wildmenu
  set wildmode=longest:full,full        " configure wildmenu

  " whitespace
  set expandtab                         " use tabs instead of spaces
  set nojoinspaces                      " use one space, not two, after punctuation
  set shiftround                        " shift to next tabstop
  set shiftwidth=2                      " amount of space used for indentation
  set softtabstop=2                     " appearance of tabs
  set tabstop=2                         " use two spaces for tabs

  " folding
  set foldmethod=indent                 " fold based on markers
  set nofoldenable                      " disable folds until `zc` or `zM` etc is used

  " text appearance
  set list                              " show invisible characters
  set listchars=tab:>·,trail:·,nbsp:¬   " but only show useful chaaracters
  set nowrap                            " disable line wrapping

  " interaction
  set backspace=2                       " make backspace work like most other apps
  set mouse=a                           " enable mouse support
  set mousehide                         " hide the mouse cursor while typing
  set whichwrap=b,s,h,l,<,>,[,]         " backspace and cursor keys wrap too
  set esckeys                           " allow cursor keys in insert mode

  " searching
  set hlsearch                          " highlight search matches
  set ignorecase                        " set case insensitive searching
  set incsearch                         " find as you type search
  set smartcase                         " case sensitive searching when not all lowercase

  " background processes
  set autoread                          " update file when changed outside of vim
  set autoindent                        " copy indentation from the previous line for new line
  set clipboard=unnamed                 " use native clipboard
  set history=200                       " store last 200 commands as history
  set lazyredraw                        " no unneeded redraws
  set nobackup                          " don't save backups
  set noerrorbells                      " no error bells please
  set noswapfile                        " no swapfiles
  set nowritebackup                     " don't save a backup while editing
  set ttyfast                           " indicates a fast terminal connection
  set undodir=~/.config/nvim/undodir    " set undofile location
  set undofile                          " maintain undo history between sessions
  set undolevels=1000                   " store 1000 undos

  " character encoding
  if !&readonly
    set fileencoding=utf-8
  endif

" Plugins
  call plug#begin()

  " syntax related
  Plug 'Shougo/deoplete.nvim', { 'do': ':UpdateRemotePlugins' }
  Plug 'alvan/vim-closetag'
  Plug 'carlitux/deoplete-ternjs', { 'do': 'npm install -g tern' }
  Plug 'editorconfig/editorconfig-vim'
  Plug 'jiangmiao/auto-pairs'
  Plug 'matze/vim-move'
  Plug 'othree/javascript-libraries-syntax.vim'
  Plug 'sheerun/vim-polyglot'
  Plug 'valloric/matchtagalways'

  " ui related
  Plug 'Xuyuanp/nerdtree-git-plugin'
  Plug 'airblade/vim-gitgutter'
  Plug 'christoomey/vim-tmux-navigator'
  Plug 'ctrlpvim/ctrlp.vim'
  Plug 'dietsche/vim-lastplace'
  Plug 'easymotion/vim-easymotion'
  Plug 'morhetz/gruvbox'
  Plug 'scrooloose/nerdtree'
  Plug 'vim-airline/vim-airline'
  Plug 'wesQ3/vim-windowswap'
  Plug 'yggdroot/indentline'
  Plug 'yssl/QFEnter'

  " background utils
  Plug 'ConradIrwin/vim-bracketed-paste'
  Plug 'jaawerth/nrun.vim'
  Plug 'neomake/neomake'
  Plug 'tmux-plugins/vim-tmux-focus-events'

  " El popo
  Plug 'tpope/vim-commentary'
  Plug 'tpope/vim-fugitive'
  Plug 'tpope/vim-repeat'
  Plug 'tpope/vim-surround'

  " add plugins to &runtimepath
  call plug#end()

" Plugin settings
  " airline
  let g:airline_powerline_fonts = 1
  let g:airline_theme='gruvbox'

  " close-tag
  let g:closetag_filenames = "*.html,*.jsx"

  " ctrlp
  let g:ctrlp_custom_ignore = 'node_modules\|DS_Store\|git'
  let g:ctrlp_show_hidden = 1
  let g:ctrlp_prompt_mappings = {
  \ 'AcceptSelection("h")': ['<c-s>'],
  \ 'AcceptSelection("v")': ['<c-v>'],
  \  }

  " deoplete
  set completeopt=longest,menuone
  let g:deoplete#auto_completion_start_length = 1
  let g:deoplete#enable_at_startup = 1
  let g:deoplete#max_list = 5
  let g:deoplete#omni#functions = {}
  let g:deoplete#sources = {}
  let g:deoplete#omni#functions.javascript = ['tern#Complete']
  let g:deoplete#sources['javascript.jsx'] = ['buffer', 'ternjs']

  " easymotion
  let g:EasyMotion_smartcase = 1
  let g:EasyMotion_keys='qwertyuiopasdfghjklzxcvbnm'

  " editorconfig
  let g:EditorConfig_exclude_patterns = ['fugitive://.*', 'scp://.*']

  " gitgutter
  let g:gitgutter_sign_column_always = 1
  let g:gitgutter_sign_added = '++'
  let g:gitgutter_sign_modified = '~~'
  let g:gitgutter_sign_removed = '__'
  let g:gitgutter_sign_removed_first_line = '¯¯'
  let g:gitgutter_sign_modified_removed = '~_'

  " vim-markdown
  let g:vim_markdown_conceal = 0

  " matchtagalways
  let g:mta_filetypes = {
    \ 'javascript.jsx': 1,
    \ 'html' : 1,
    \ 'xml' : 1,
    \ }

  " neomake
  let g:neomake_javascript_enabled_makers = ['eslint']
  let g:neomake_jsx_enabled_makers = ['eslint']
  let g:neomake_error_sign = {'text': 'xx'}
  let g:neomake_warning_sign = {'text': '!!'}

  " nerdtree
  let NERDTreeMapActivateNode='l'
  let NERDTreeMapCloseDir='h'
  let NERDTreeMapOpenSplit='<c-s>'
  let NERDTreeMapOpenVSplit='<c-v>'

  " ternjs
  let g:tern_show_signature_in_pum = 1
  let g:tern#filetypes = [
    \ 'jsx',
    \ 'javascript.jsx',
    \ ]

  " theme settings
  let g:gruvbox_italic = 1
colorscheme gruvbox

" ----- Keybindings -----
nore ; :
nore \ ;
noremap ` ^
inore jj <Esc>

noremap <Up> <NOP>
noremap <DOWN> <NOP>
noremap <Left> <NOP>
noremap <Right> <NOP>

" set leader to space
let mapleader = " "

" keep selection after indent
vnoremap < <gv
vnoremap > >gv

" prevent entering ex mode accidentally
nnoremap Q <Nop><Paste>

" sort
vnoremap <leader>s :sort<CR>

" move through deoplete suggestions with tab
inoremap <expr><tab> pumvisible() ? "\<c-n>" : "\<tab>"

" Autocommands
  if has("autocmd")

    " disable comment continuation
    autocmd FileType * setlocal formatoptions-=c formatoptions-=r formatoptions-=o

    " set neomake's eslint path to the local eslint, and enable it as a maker
    autocmd BufEnter *.js,*.jsx let b:neomake_javascript_eslint_exe = nrun#Which('eslint')
    autocmd! BufEnter,BufWritePost * Neomake

    " better syntax highlighting
    autocmd BufNewFile,BufRead *eslintrc,*babelrc setlocal syntax=json

  endif

" Searching
  if executable('ag')

    " use ag over grep
    set grepprg=ag\ --nogroup\ --nocolor

    " define Ag command
    command! -nargs=+ -complete=file -bar Ag silent! grep! <args>|cwindow|redraw!

    " bind \ to grep shortcut
    nnoremap \ :Ag<SPACE>

endif
