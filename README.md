# Dotfiles

Personal dotfiles for macOS and Linux, managed with [GNU Stow](https://www.gnu.org/software/stow/).

![Mac Screenshot](.mac-screenshot.png)

## Quick Start

One-liner for a fresh machine (no git/SSH required):

```bash
curl -fsSL https://raw.githubusercontent.com/thorvn/dotfiles/master/meta/bootstrap.sh | bash
```

Or if you already have git:

```bash
git clone https://github.com/thorvn/dotfiles.git ~/.dotfiles
cd ~/.dotfiles
bash meta/install.sh
```

### How Stow Works Here

- **`home/`** is a stow directory with per-tool packages. Each subdirectory is stowed independently: `stow -d home -t $HOME git`
- **`config/`** is a single stow package targeting `~/.config`: `stow --no-folding -t ~/.config config`
- **`archive/`** holds old configs for reference. Never stowed.
- **`meta/`** contains install scripts and non-stowable files.

## Usage

```bash
# Stow everything
make all

# Unstow everything
make uninstall

# Stow/unstow a single home package
make pkg PKG=git
make unpkg PKG=git
```

All stow commands use `-R` (restow) so `make all` is safe to run repeatedly.

`--no-folding` is used for `config/` to prevent stow from symlinking entire directories, so apps can write their own files (fish_variables, lazy-lock.json, etc.) without polluting the repo.

## Components

**Shell & Terminal:**
Fish, Starship, Ghostty, Tmux

**Editor:**
Neovim (LazyVim)

**CLI Tools:**
ripgrep, eza, bat, fzf, zoxide, lazygit, git-delta, pnpm

**macOS:**
Karabiner-Elements

**Version Management:**
mise

## Local Configuration

These files are created by `install.sh` but not tracked by git:

- `~/.gitconfig.local` — personal git user info (name, email)
- `~/.config/fish/config.local.fish` — machine-specific fish config

## Platform Notes

### macOS
- Uses Homebrew for package management
- Karabiner config stowed automatically
- System preferences applied via `meta/scripts/macos_config.fish`

### Linux
- Uses apt for dependencies
- Install scripts in `meta/software/` and `meta/scripts/`

## After Bootstrap

Switch the remote to SSH once you have keys set up:

```bash
cd ~/.dotfiles && git remote set-url origin git@github.com:thorvn/dotfiles.git
```
