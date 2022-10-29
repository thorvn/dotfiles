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

# Customize to your needs...
export KEYTIMEOUT=20
export FZF_DEFAULT_COMMAND='ag -g ""'
export EDITOR='nvim'
export ZSH_AUTOSUGGEST_HIGHLIGHT_STYLE='fg=8'
export VISUAL="vim"
export EDITOR="vim"
export ZSH_DISABLE_COMPFIX='true'

# PATH
export PATH="/usr/local/sbin:$PATH"
export PATH=$PATH:/usr/local/mysql/bin
export PATH=$PATH:$HOME/.rbenv/bin
export PATH=$PATH:$HOME/.fnm/

if [ -z "$TMUX" ]; then
  tmux -u || tmux new
fi

# Load FNM
eval "$(fnm env --use-on-cd)"
eval "$(rbenv init -)"

# load aliases
source ~/.aliases

# load custom function
source ~/.functions

[ -f ~/.fzf.zsh ] && source ~/.fzf.zsh

setopt no_share_history


