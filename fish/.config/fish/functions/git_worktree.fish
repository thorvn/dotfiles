# Jump between worktrees with fzf — gwj
function gwj --description 'Jump to git worktree'
    set -l wt (git worktree list | fzf --preview 'git -C {1} log --oneline -10' | awk '{print $1}')
    test -n "$wt" && cd $wt
end

# Create worktree from PR number — gwpr
function gwpr --description 'Checkout PR as worktree'
    set -l pr $argv[1]
    set -l branch "pr-$pr"
    set -l root (git rev-parse --show-toplevel)
    set -l name (basename $root)
    git fetch origin "pull/$pr/head:$branch"
    git worktree add "$root/../$name-$branch" "$branch"
    cd "$root/../$name-$branch"
end

# Create new worktree with a new branch — gwa <branch>
function gwa --description 'Add worktree with new branch'
    set -l branch $argv[1]
    set -l root (git rev-parse --show-toplevel)
    set -l name (basename $root)
    git worktree add -b "$branch" "$root/../$name-$branch"
    cd "$root/../$name-$branch"
end

# Remove worktree interactively — gwrm
function gwrm --description 'Remove a worktree with fzf picker'
    set -l wt (git worktree list | fzf | awk '{print $1}')
    test -n "$wt" && git worktree remove $wt
end
