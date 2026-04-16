# Set environment variables
set -gx EDITOR nvim
set -gx XDG_CONFIG_HOME $HOME/.config

# Add common paths
fish_add_path /opt/homebrew/bin
fish_add_path /opt/homebrew/Caskroom
fish_add_path $HOME/.local/bin
fish_add_path /opt/homebrew/opt/libpq/bin
fish_add_path $HOME/.local/bin
fish_add_path $HOME/.swiftly
fish_add_path $HOME/.bun/bin

# opencode
fish_add_path $HOME/.opencode/bin

# Added by Antigravity
fish_add_path $HOME/.antigravity/antigravity/bin


# set -gx STARSHIP_CONFIG $HOME/startship.toml

# Change to home directory in interactive sessions
# if status is-interactive
#   cd $HOME
# end

# Initialize tools
starship init fish | source
fzf --fish | source
zoxide init fish | source
mise activate fish | source
direnv hook fish | source
source "$HOME/.cargo/env.fish"

# Source aliases if the file exists
if test -f ~/.config/fish/alias.fish
  source ~/.config/fish/alias.fish
end

# Source local config if it exists
if test -f ~/.config/fish/config.local.fish
  source ~/.config/fish/config.local.fish
end

source ~/.config/fish/functions/git_worktree.fish
source ~/.config/fish/functions/utils.fish

# pnpm
set -gx PNPM_HOME $HOME/Library/pnpm
if not string match -q -- $PNPM_HOME $PATH
  set -gx PATH "$PNPM_HOME" $PATH
end
# pnpm end

# Added by OrbStack: command-line tools and integration
# This won't be added again if you remove it.
source ~/.orbstack/shell/init2.fish 2>/dev/null || :
