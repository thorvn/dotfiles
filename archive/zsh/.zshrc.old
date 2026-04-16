#
# Executes commands at the start of an interactive session.
#
# Authors:
#   Sorin Ionescu <sorin.ionescu@gmail.com>
#

# Source Prezto.
if [[ -s "${ZDOTDIR:-$HOME}/.zprezto/init.zsh" ]]; then
  source "${ZDOTDIR:-$HOME}/.zprezto/init.zsh"
fi

# . /opt/homebrew/opt/asdf/libexec/asdf.sh

# Customize to your needs...
export KEYTIMEOUT=20
export FZF_DEFAULT_COMMAND='rg ""'
export ZSH_AUTOSUGGEST_HIGHLIGHT_STYLE='fg=240'
export VISUAL="nvim"
export EDITOR="nvim"
export ZSH_DISABLE_COMPFIX='true'
export FZF_DEFAULT_OPTS="--history=$HOME/.fzf-history"
export FZF_CTRL_T_OPTS="
  --preview 'bat -n --color=always {}'
  --bind 'ctrl-/:change-preview-window(down|hidden|)'"
export FZF_ALT_C_OPTS="--preview 'tree -C {}'"
export FZF_COMPLETION_TRIGGER='~~'

# PATH
export PATH="/usr/local/sbin:$PATH"
export PATH=$PATH:$HOME/.arcanist/bin
export PATH=$PATH:$HOME/go/bin
export PATH=$PATH:$HOME/.local/bin
export PATH=$PATH:/opt/homebrew/bin
export XDG_CONFIG_HOME="$HOME/.config"

# if [ -z "$TMUX" ]; then
#  tmux -u || tmux new -c ~
# fi

# load aliases
source ~/.aliases

# load custom function
source ~/.functions

[ -f ~/.fzf.zsh ] && source ~/.fzf.zsh

setopt no_share_history
