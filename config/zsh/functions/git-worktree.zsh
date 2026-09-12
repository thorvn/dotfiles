# Safe helpers for the shared Git worktree workflow.

_dotfiles_git_worktree_root() {
  local root
  root=$(command git rev-parse --show-toplevel 2>/dev/null) || {
    print -u2 -- 'git worktree: not inside a Git worktree'
    return 1
  }
  print -r -- "$root"
}

_dotfiles_git_worktree_main_root() {
  _dotfiles_git_worktree_root >/dev/null || return

  local line listing
  listing=$(command git worktree list --porcelain) || {
    print -u2 -- 'git worktree: unable to list worktrees'
    return 1
  }
  while IFS= read -r line; do
    if [[ $line == 'worktree '* ]]; then
      print -r -- "${line#worktree }"
      return 0
    fi
  done <<< "$listing"

  print -u2 -- 'git worktree: unable to find the primary worktree'
  return 1
}

_dotfiles_git_worktree_paths() {
  _dotfiles_git_worktree_root >/dev/null || return

  local line listing
  listing=$(command git worktree list --porcelain) || {
    print -u2 -- 'git worktree: unable to list worktrees'
    return 1
  }
  while IFS= read -r line; do
    [[ $line == 'worktree '* ]] && print -r -- "${line#worktree }"
  done <<< "$listing"
  return 0
}

_dotfiles_git_worktree_destination() {
  local branch=$1
  local main_root
  main_root=$(_dotfiles_git_worktree_main_root) || return

  local slug=${branch//\//-}
  slug=${slug//[^[:alnum:]._-]/-}

  print -r -- "${main_root:h}/${main_root:t}-worktrees/$slug"
}

_dotfiles_git_worktree_pick() {
  (( $+commands[fzf] )) || {
    print -u2 -- 'git worktree: fzf is required for interactive selection'
    return 1
  }

  local prompt=$1
  shift
  (( $# )) || {
    print -u2 -- 'git worktree: no eligible worktrees found'
    return 1
  }

  print -rl -- "$@" | command fzf \
    --prompt="$prompt" \
    --preview='git -C {} status --short'
}

gwj() {
  if (( $# )); then
    print -u2 -- 'usage: gwj'
    return 2
  fi

  local -a paths
  paths=("${(@f)$(_dotfiles_git_worktree_paths)}") || return

  local selected
  selected=$(_dotfiles_git_worktree_pick 'jump> ' "${paths[@]}") || return
  [[ -n $selected ]] || return 0

  builtin cd -- "$selected"
}

gwpr() {
  if (( $# != 1 )) || [[ ! $1 =~ '^[1-9][0-9]*$' ]]; then
    print -u2 -- 'usage: gwpr <pull-request-number>'
    return 2
  fi

  _dotfiles_git_worktree_root >/dev/null || return
  command git remote get-url origin >/dev/null 2>&1 || {
    print -u2 -- 'gwpr: the repository has no origin remote'
    return 1
  }

  local pr=$1
  local branch="pr-$pr"
  local destination
  destination=$(_dotfiles_git_worktree_destination "$branch") || return

  if command git show-ref --verify --quiet "refs/heads/$branch"; then
    print -u2 -- "gwpr: branch already exists: $branch"
    return 1
  fi
  if [[ -e $destination ]]; then
    print -u2 -- "gwpr: destination already exists: $destination"
    return 1
  fi

  command mkdir -p -- "${destination:h}" || return
  command git fetch origin \
    "refs/pull/$pr/head:refs/heads/$branch" || return
  command git worktree add -- "$destination" "$branch" || return
  builtin cd -- "$destination"
}

gwa() {
  if (( $# < 1 || $# > 2 )); then
    print -u2 -- 'usage: gwa <new-branch> [start-point]'
    return 2
  fi

  _dotfiles_git_worktree_root >/dev/null || return

  local branch=$1
  command git check-ref-format --branch "$branch" >/dev/null 2>&1 || {
    print -u2 -- "gwa: invalid branch name: $branch"
    return 2
  }
  if command git show-ref --verify --quiet "refs/heads/$branch"; then
    print -u2 -- "gwa: branch already exists: $branch"
    return 1
  fi

  local destination
  destination=$(_dotfiles_git_worktree_destination "$branch") || return
  if [[ -e $destination ]]; then
    print -u2 -- "gwa: destination already exists: $destination"
    return 1
  fi

  local start_point=${2:-HEAD}
  command git rev-parse --verify --quiet "${start_point}^{commit}" >/dev/null || {
    print -u2 -- "gwa: invalid start point: $start_point"
    return 1
  }

  command mkdir -p -- "${destination:h}" || return
  command git worktree add -b "$branch" -- \
    "$destination" "$start_point" || return
  builtin cd -- "$destination"
}

gwrm() {
  if (( $# )); then
    print -u2 -- 'usage: gwrm'
    return 2
  fi

  local current_root main_root
  current_root=$(_dotfiles_git_worktree_root) || return
  main_root=$(_dotfiles_git_worktree_main_root) || return

  local -a paths removable
  local candidate
  paths=("${(@f)$(_dotfiles_git_worktree_paths)}") || return
  for candidate in "${paths[@]}"; do
    [[ $candidate == "$main_root" || $candidate == "$current_root" ]] || \
      removable+=("$candidate")
  done

  local selected
  selected=$(_dotfiles_git_worktree_pick 'remove> ' "${removable[@]}") || return
  [[ -n $selected ]] || return 0

  command git worktree remove -- "$selected"
}
