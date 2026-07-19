# Deterministic environment shared by interactive and non-interactive Zsh.
: ${XDG_CONFIG_HOME:=$HOME/.config}
: ${XDG_CACHE_HOME:=$HOME/.cache}
: ${XDG_DATA_HOME:=$HOME/.local/share}
: ${XDG_STATE_HOME:=$HOME/.local/state}

export XDG_CONFIG_HOME XDG_CACHE_HOME XDG_DATA_HOME XDG_STATE_HOME
export ZDOTDIR=$XDG_CONFIG_HOME/zsh
export EDITOR=nvim
export VISUAL=$EDITOR

# Debian/Ubuntu's global zshrc calls compinit unless this is set. Export it so
# nested Zsh processes inherit the policy after ZDOTDIR changes where they look
# for .zshenv. Completion is initialized explicitly by our .zshrc instead.
export skip_global_compinit=1

typeset -U path PATH
path=(
  /opt/homebrew/bin
  /opt/homebrew/Caskroom
  /opt/homebrew/opt/libpq/bin
  $HOME/.local/bin
  $HOME/.swiftly
  $HOME/.bun/bin
  $HOME/.opencode/bin
  $HOME/.antigravity/antigravity/bin
  $path
)
export PATH
