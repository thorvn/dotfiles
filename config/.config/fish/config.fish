
# commands to run in interactive sessions can go here
starship init fish | source
fzf --fish | source
zoxide init fish | source
source /opt/homebrew/opt/asdf/libexec/asdf.fish

source ~/.config/fish/alias.fish
source ~/.config/fish/config.local.fish

# pnpm
set -gx PNPM_HOME "/Users/kenrick/Library/pnpm"
if not string match -q -- $PNPM_HOME $PATH
  set -gx PATH "$PNPM_HOME" $PATH
end
# pnpm end
