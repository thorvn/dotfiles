# Shared aliases tracked for use on every machine.
alias g='git'
alias v='nvim'
alias vi='nvim'
alias vim='nvim'
alias lg='lazygit'

alias gls='git remote -v'
alias gca='git commit --amend'
alias gc='git commit -m'
alias gss='git status -s'
alias ghide='git update-index --assume-unchanged'
alias gunhide='git update-index --no-assume-unchanged --no-skip-worktree'
alias ghidels="git ls-files -v | grep '^h'"
alias gfa='git fetch --all --prune'
alias gwl='git worktree list'

alias ls='eza --icons'
if (( $+commands[bat] )); then
  alias cat='bat'
elif (( $+commands[batcat] )); then
  alias cat='batcat'
fi
alias cc='$HOME/.local/bin/claude'
alias zz='zellij'

if [[ $OSTYPE == darwin* ]] && (( $+commands[open] )); then
  alias done='open "raycast://confetti"'
fi

alias rspec='bundle exec rspec'
alias tm='task-master'
