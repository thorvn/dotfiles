fish_add_path /opt/homebrew/bin
fish_add_path $HOME/.asdf/shims
fish_add_path $HOME/.local/bin
set -gx EDITOR nvim
set -gx XDG_CONFIG_HOME $HOME/.config

# if which asdf > /dev/null; status --is-interactive; and source (brew --prefix asdf)/asdf.fish; end
if not set -q TMUX
    set -g TMUX tmux new-session -d -s base
    eval $TMUX
    tmux attach-session -d -t base
end

if status is-interactive
  cd $HOME
end

# commands to run in interactive sessions can go here
starship init fish | source
fzf --fish | source
zoxide init fish | source
source /opt/homebrew/opt/asdf/libexec/asdf.fish

source ~/.config/fish/alias.fish
source ~/.config/fish/config.local.fish

# pnpm
set -gx PNPM_HOME $HOME/Library/pnpm
if not string match -q -- $PNPM_HOME $PATH
  set -gx PATH "$PNPM_HOME" $PATH
end
# pnpm end
