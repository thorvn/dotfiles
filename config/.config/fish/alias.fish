alias g="git"
alias v="nvim"
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

# Software replacement
alias ls='eza --icons'
alias cd='z'
alias cat='bat'

##### RUBY #####
alias rspec='bundle exec rspec'
