# Native interactive Zsh policy. Network access does not belong in startup.

unsetopt AUTO_CD AUTO_PUSHD

# Keep history useful for recall without importing commands from other live shells.
HISTFILE=$XDG_STATE_HOME/zsh/history
HISTSIZE=50000
SAVEHIST=50000

zmodload zsh/files
if [[ ! -d ${HISTFILE:h} ]]; then
  mkdir -p -- "${HISTFILE:h}"
fi

unsetopt HIST_IGNORE_SPACE INC_APPEND_HISTORY SHARE_HISTORY
setopt APPEND_HISTORY
setopt EXTENDED_HISTORY
setopt HIST_FIND_NO_DUPS
setopt HIST_IGNORE_DUPS
setopt HIST_NO_STORE
setopt INC_APPEND_HISTORY_TIME

autoload -Uz add-zsh-hook
zsh_history_filter() {
  setopt localoptions extendedglob
  local command=${1%$'\n'}
  command=${command##[[:space:]]#}
  command=${command%%[[:space:]]#}

  case $command in
    gss|ls|eza|pwd|cd|z|clear|exit|history)
      return 1
      ;;
  esac

  if (( ${+aliases[$command]} )); then
    return 1
  fi

  return 0
}
add-zsh-hook zshaddhistory zsh_history_filter

# Native completion with an XDG-owned cache and compinit's security checks intact.
zsh_completion_cache=$XDG_CACHE_HOME/zsh
if [[ ! -d $zsh_completion_cache ]]; then
  mkdir -p -- "$zsh_completion_cache"
fi

zstyle ':completion:*' menu select
zstyle ':completion:*' group-name ''
zstyle ':completion:*:descriptions' format '%F{yellow}-- %d --%f'
zstyle ':completion:*' matcher-list \
  'm:{a-zA-Z}={A-Za-z}' \
  'r:|[._-]=* r:|=*'
zstyle ':completion:*' use-cache on
zstyle ':completion:*' cache-path "$zsh_completion_cache"

autoload -Uz compinit
compinit -d "$zsh_completion_cache/.zcompdump"
unset zsh_completion_cache

source "$ZDOTDIR/alias.zsh"

if [[ -r $ZDOTDIR/functions/git-worktree.zsh ]]; then
  source "$ZDOTDIR/functions/git-worktree.zsh"
fi

# Optional tools initialize at most once and never install themselves at startup.
if [[ -r $HOME/.cargo/env ]]; then
  source "$HOME/.cargo/env"
fi

if [[ $OSTYPE == darwin* && -r $HOME/.orbstack/shell/init2.zsh ]]; then
  source "$HOME/.orbstack/shell/init2.zsh"
fi

if (( $+commands[mise] )); then
  eval "$(mise activate zsh)"
fi

if (( $+commands[zoxide] )); then
  eval "$(zoxide init zsh)"
fi

if (( $+commands[direnv] )); then
  eval "$(direnv hook zsh)"
fi

if (( $+commands[starship] )); then
  eval "$(starship init zsh)"
fi

if [[ -r $ZDOTDIR/local.zsh ]]; then
  source "$ZDOTDIR/local.zsh"
fi

# zsh-vi-mode initializes synchronously with Zsh's stable ZLE readkey engine.
# FZF is loaded by the manifest immediately after vi mode so its widgets win,
# followed by autosuggestions and syntax highlighting.
: ${ZVM_INIT_MODE:=sourcing}
: ${ZVM_READKEY_ENGINE:=zle}

zsh_fzf_init() {
  (( ${ZSH_FZF_INITIALIZED:-0} )) && return
  (( $+commands[fzf] )) || return
  [[ -o zle && -t 0 && -t 1 ]] || return

  local fzf_init key_bindings
  if fzf_init=$(fzf --zsh 2>/dev/null) && eval "$fzf_init"; then
    typeset -g ZSH_FZF_INITIALIZED=1
    return
  fi

  for key_bindings in \
    /usr/share/doc/fzf/examples/key-bindings.zsh \
    /usr/share/fzf/shell/key-bindings.zsh \
    /usr/share/fzf/key-bindings.zsh
  do
    if [[ -r $key_bindings ]] && source "$key_bindings"; then
      typeset -g ZSH_FZF_INITIALIZED=1
      return
    fi
  done

  return 1
}

zsh_plugin_file=${ZSH_PLUGIN_FILE:-$XDG_CACHE_HOME/antidote/zsh_plugins.zsh}
typeset -g ZSH_PLUGIN_STACK_READY=0
zsh_plugin_root=${zsh_plugin_file:h}
zsh_plugin_entrypoints=(
  "$zsh_plugin_root/github.com/jeffreytse/zsh-vi-mode/zsh-vi-mode.plugin.zsh"
  "$zsh_plugin_root/github.com/zsh-users/zsh-autosuggestions/zsh-autosuggestions.plugin.zsh"
  "$zsh_plugin_root/github.com/zsh-users/zsh-syntax-highlighting/zsh-syntax-highlighting.plugin.zsh"
)
zsh_plugin_implementations=(
  "$zsh_plugin_root/github.com/jeffreytse/zsh-vi-mode/zsh-vi-mode.zsh"
  "$zsh_plugin_root/github.com/zsh-users/zsh-autosuggestions/zsh-autosuggestions.zsh"
  "$zsh_plugin_root/github.com/zsh-users/zsh-syntax-highlighting/zsh-syntax-highlighting.zsh"
)

zsh_plugins_ready() {
  local plugin_entrypoint plugin_implementation
  [[ -r $zsh_plugin_file ]] || return 1
  for plugin_entrypoint in "${zsh_plugin_entrypoints[@]}"; do
    [[ -r $plugin_entrypoint ]] || return 1
  done
  for plugin_implementation in "${zsh_plugin_implementations[@]}"; do
    [[ -r $plugin_implementation ]] || return 1
  done
}

if zsh_plugins_ready; then
  if source "$zsh_plugin_file"; then
    typeset -g ZSH_PLUGIN_STACK_READY=1
  else
    print -u2 -- 'zsh: plugin cache is invalid; run the dotfiles installer to restore interactive plugins'
    zsh_fzf_init
  fi
else
  print -u2 -- 'zsh: plugins unavailable; run the dotfiles installer to restore interactive plugins'
  zsh_fzf_init
fi
unfunction zsh_plugins_ready
unset zsh_plugin_file zsh_plugin_root zsh_plugin_entrypoints zsh_plugin_implementations
