alias g="git"
alias v="nvim"
alias vi="nvim"
alias lg="lazygit"

############## GIT #####################

alias gls="git remote -v"
alias gca="git commit --amend"
alias greset="git reset --hard && git clean -f"
alias gc="git commit -m"
alias gss="git status -s"
alias ghide="git update-index --assume-unchanged"
alias gunhide="git update-index --no-assume-unchanged --no-skip-worktree"
alias ghidels="git ls-files -v|grep '^h'"
alias gfa="git fetch --all --prune"
alias gwl="git worktree list"
alias gwa="git worktree add"
alias gwr="git worktree remove"

# Software replacement
alias ls='eza --icons'
alias cd='z'
alias cat='bat'
alias cc='~/.local/bin/claude'
alias zz='zellij'

##### RUBY #####
alias rspec='bundle exec rspec'

alias done='open "raycast://confetti"'
alias tm='task-master'
