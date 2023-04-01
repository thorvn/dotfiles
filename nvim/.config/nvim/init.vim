" ----- General settings -----
source $HOME/.config/nvim/vimrc.base.settings

" ----- Keybindings -----
source $HOME/.config/nvim/vimrc.keybindings

source $HOME/.config/nvim/plugins.vim
if exists('g:vscode')
  highlight QuickScopePrimary guifg='#afff5f' gui=underline ctermfg=155 cterm=underline
  highlight QuickScopeSecondary guifg='#5fffff' gui=underline ctermfg=81 cterm=underline

  source $HOME/.config/nvim/vscode/keymapping.vim
else
endif
" ----- Plugin settings -----
"source ./vimrc.plugins.settings
