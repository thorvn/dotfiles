# Add common paths
fish_add_path /opt/homebrew/bin
fish_add_path $HOME/.asdf/shims
fish_add_path $HOME/.local/bin

# Set environment variables
set -gx EDITOR nvim
set -gx XDG_CONFIG_HOME $HOME/.config

# Change to home directory in interactive sessions
if status is-interactive
  cd $HOME
end

# Initialize tools
starship init fish | source
fzf --fish | source
zoxide init fish | source

# Source asdf
source /opt/homebrew/opt/asdf/libexec/asdf.fish

# Source aliases if the file exists
if test -f ~/.config/fish/alias.fish
    source ~/.config/fish/alias.fish
end

# Source local config if it exists
if test -f ~/.config/fish/config.local.fish
    source ~/.config/fish/config.local.fish
end

# pnpm
set -gx PNPM_HOME $HOME/Library/pnpm
if not string match -q -- $PNPM_HOME $PATH
  set -gx PATH "$PNPM_HOME" $PATH
end
# pnpm end

# Improved history management
function clean_fish_history
    # Common commands to remove
    set -l common_cmds z cd gss exit ls ll la pwd clear history

    # Potentially sensitive commands to remove
    set -l sensitive_cmds \
        # Commands potentially containing passwords or tokens
        'sudo*' 'passwd*' '*password*' '*token*' '*api_key*' \
        # SSH commands
        'ssh*' 'scp*' \
        # Git commands that might include sensitive info
        'git push*' 'git commit*' 'git config*' \
        # Commands accessing sensitive files
        'cat *id_rsa*' 'cat *.pem' 'cat *.key' 'cat *config*' \
        # Database access commands
        'mysql*' 'psql*' 'mongo*' 'redis-cli*' \
        # Network-related commands
        'curl*' 'wget*' 'netstat*' 'ifconfig*' 'ip a*' \
        # Commands that might reveal infrastructure
        'aws*' 'gcloud*' 'az*' 'docker*' 'kubectl*' \
        # Other potentially sensitive commands
        'env' 'set' 'export'

    # Remove common commands
    for cmd in $common_cmds
        history delete --case-sensitive --exact $cmd
    end

    # Remove sensitive commands
    for pattern in $sensitive_cmds
        history delete --case-sensitive --contains $pattern
    end

    # Limit history to last 1000 items
    set -l overflow (math (count (history search --show-time --max-count=0 '')) - 1000)
    if test $overflow -gt 0
        history delete --exact --case-sensitive (history search --show-time --max-count=$overflow '' | string split ' ' -f3-)
    end
end

# Run history cleanup on shell exit
function on_exit --on-event fish_exit
    clean_fish_history
end

# Optionally, you can also clean history periodically or on shell startup
# Uncomment the following line to clean history on shell startup
# clean_fish_history
