# Set environment variables
set -gx EDITOR nvim
set -gx XDG_CONFIG_HOME $HOME/.config

# Add paths (fish_add_path -m handles duplicates and existence)
fish_add_path -m /opt/homebrew/bin
fish_add_path -m /opt/homebrew/Caskroom
fish_add_path -m /opt/homebrew/opt/libpq/bin
fish_add_path -m $HOME/.local/bin
fish_add_path -m $HOME/.swiftly
fish_add_path -m $HOME/.bun/bin
fish_add_path -m $HOME/.opencode/bin
fish_add_path -m $HOME/.antigravity/antigravity/bin

# Always-on tools: PATH/env, plus starship (async-prompt subprocesses need fish_prompt defined)
command -q mise;     and mise activate fish | source
command -q starship; and starship init fish | source
test -f $HOME/.cargo/env.fish; and source $HOME/.cargo/env.fish

# Interactive-only tools (keybindings, hooks)
if status is-interactive
    command -q fzf;    and fzf --fish | source
    command -q zoxide; and zoxide init fish | source
    command -q direnv; and direnv hook fish | source
end

# Source aliases if the file exists
if test -f ~/.config/fish/alias.fish
    source ~/.config/fish/alias.fish
end

# Source local config if it exists
if test -f ~/.config/fish/config.local.fish
    source ~/.config/fish/config.local.fish
end

# Function names don't match filename, so fish's autoloader can't lazy-load them
source ~/.config/fish/functions/git_worktree.fish

# Added by OrbStack: command-line tools and integration (macOS only)
if test (uname) = Darwin; and test -f ~/.orbstack/shell/init2.fish
    source ~/.orbstack/shell/init2.fish
end
