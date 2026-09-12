# Thin fzf helpers around Git's native worktree safeguards.

_dotfiles_git_worktree_paths() {
  setopt localoptions pipefail
  command git worktree list --porcelain | command sed -n 's/^worktree //p'
}

_dotfiles_git_worktree_destination() {
  local main_root
  main_root=$(_dotfiles_git_worktree_paths) || return
  main_root=${main_root%%$'\n'*}

  local slug=${1//\//-}
  slug=${slug//[^[:alnum:]._-]/-}
  print -r -- "${main_root:h}/${main_root:t}-worktrees/$slug"
}

_dotfiles_git_worktree_pick() {
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
  local selected
  selected=$(_dotfiles_git_worktree_pick 'jump> ' "${(@f)$(_dotfiles_git_worktree_paths)}") || return
  builtin cd -- "$selected"
}

gwpr() {
  if (( $# != 1 )) || [[ ! $1 =~ '^[1-9][0-9]*$' ]]; then
    print -u2 -- 'usage: gwpr <pull-request-number>'
    return 2
  fi

  local branch="pr-$1" destination
  destination=$(_dotfiles_git_worktree_destination "$branch") || return
  command git fetch origin "refs/pull/$1/head" &&
    command git worktree add -b "$branch" -- "$destination" FETCH_HEAD &&
    builtin cd -- "$destination"
}

gwa() {
  if (( $# < 1 || $# > 2 )); then
    print -u2 -- 'usage: gwa <new-branch> [start-point]'
    return 2
  fi

  local destination
  destination=$(_dotfiles_git_worktree_destination "$1") || return
  command git worktree add -b "$1" -- "$destination" "${2:-HEAD}" &&
    builtin cd -- "$destination"
}

gwrm() {
  local current_root main_root candidate selected
  local -a paths removable
  current_root=$(command git rev-parse --show-toplevel) || return
  paths=("${(@f)$(_dotfiles_git_worktree_paths)}") || return
  main_root=$paths[1]

  for candidate in "${paths[@]}"; do
    [[ $candidate == "$main_root" || $candidate == "$current_root" ]] || removable+=("$candidate")
  done

  selected=$(_dotfiles_git_worktree_pick 'remove> ' "${removable[@]}") || return
  command git worktree remove -- "$selected"
}
