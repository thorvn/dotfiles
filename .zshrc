# If you come from bash you might have to change your $PATH.
export PATH=$HOME/bin:/usr/local/bin:$PATH

# Path to your oh-my-zsh installation.
export ZSH=$HOME/.oh-my-zsh
export NVM_DIR="$HOME/.nvm"
# [ -s "$NVM_DIR/nvm.sh" ] && . "$NVM_DIR/nvm.sh" # This loads nvm

# Gem user-install
if which ruby >/dev/null && which gem >/dev/null; then
    PATH="$(ruby -rubygems -e 'puts Gem.user_dir')/bin:$PATH"
fi

# Use vim key bindings
bindkey -v

# use jj to enter vim cmd mode
bindkey jk vi-cmd-mode

export KEYTIMEOUT=20

export FZF_DEFAULT_COMMAND='ag -g ""'

if [ -z "$TMUX" ]; then
  tmux -u || tmux new
fi

DISABLE_AUTO_UPDATE="true"

plugins=(git zsh-autosuggestions )

source $ZSH/oh-my-zsh.sh

# load aliases
source ~/.aliases

# User configuration

# You may need to manually set your language environment
export LANG=en_US.UTF-8

# Preferred editor for local and remote sessions
if [[ -n $SSH_CONNECTION ]]; then
  export EDITOR='nvim'
else
  export EDITOR='nvim'
fi

# Compilation flags
# export ARCHFLAGS="-arch x86_64"

eval "$(rbenv init -)"

[ -f ~/.fzf.zsh ] && source ~/.fzf.zsh

case $(uname) in
Linux)
  [ -f ~/.zshrc.linux ] && source ~/.zshrc.linux
  [ -f ~/.zshrc.theme.linux ] && source ~/.zshrc.theme.linux
  [ -f ~/.zshrc.alias.linux ] && source ~/.zshrc.alias.linux
  source ~/.zsh/zsh-autosuggestions/zsh-autosuggestions.zsh
  ;;
Darwin)
  source <(kubectl completion zsh)
  [ -f ~/.zshrc.theme.osx ] && source ~/.zshrc.theme.osx
  source /usr/local/share/zsh-autosuggestions/zsh-autosuggestions.zsh # Install with brew
  ;;
esac

setopt no_share_history
