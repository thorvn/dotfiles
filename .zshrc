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

if [ -z "$TMUX" ]; then
  tmux -u || tmux new
fi

# Load nvm
export NVM_DIR="$HOME/.nvm"
[ -s "$NVM_DIR/nvm.sh" ] && \. "$NVM_DIR/nvm.sh" # This loads nvm
[ -s "$NVM_DIR/bash_completion" ] && \. "$NVM_DIR/bash_completion"

# Load asdf
. $HOME/.asdf/asdf.sh
. $HOME/.asdf/completions/asdf.bash

# load aliases
source ~/.aliases

# load custom function
source ~/.functions


[ -f ~/.fzf.zsh ] && source ~/.fzf.zsh

setopt no_share_history

# Add RVM to PATH for scripting. Make sure this is the last PATH variable change.
export PATH="$PATH:$HOME/.rvm/bin"
export PATH="/usr/local/sbin:$PATH"
export PATH=$PATH:/usr/local/mysql/bin
