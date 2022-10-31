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

. /opt/homebrew/opt/asdf/libexec/asdf.sh

# Customize to your needs...
export KEYTIMEOUT=20
export FZF_DEFAULT_COMMAND='ag -g ""'
export ZSH_AUTOSUGGEST_HIGHLIGHT_STYLE='fg=240'
export VISUAL="vim"
export EDITOR="vim"
export ZSH_DISABLE_COMPFIX='true'

# PATH
export PATH="/usr/local/sbin:$PATH"
export PATH=$PATH:$HOME/.fnm/
export PATH=$PATH:$HOME/.arcanist/bin
export PATH=$PATH:$HOME/go/bin
export PATH=$PATH:$HOME/.local/bin
export PATH="/opt/homebrew/opt/php@8.0/bin:$PATH"

#if [ -z "$TMUX" ]; then
#  tmux -u || tmux new
#fi

# Load FNM
eval "$(fnm env --use-on-cd)"
eval "$(rbenv init -)"

# load aliases
source ~/.aliases

# load custom function
source ~/.functions

[ -f ~/.fzf.zsh ] && source ~/.fzf.zsh

setopt no_share_history
