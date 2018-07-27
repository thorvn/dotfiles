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

if [ -z "$TMUX" ]; then
  tmux -u || tmux new
fi

# Load asdf
. $HOME/.asdf/asdf.sh
. $HOME/.asdf/completions/asdf.bash

# load aliases
source ~/.aliases

# load custom function
source ~/.functions


[ -f ~/.fzf.zsh ] && source ~/.fzf.zsh

setopt no_share_history
