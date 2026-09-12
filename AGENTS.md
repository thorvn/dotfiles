# Repository Guidelines

## Project Structure & Module Organization

This repository manages macOS and Linux dotfiles with GNU Stow. `home/` contains per-tool packages that target `$HOME` (`git/`, `ruby/`, and `zsh/`). `config/` is one package targeting `~/.config`; it holds active Neovim, tmux, shell, terminal, and CLI-tool configuration. Installation and platform provisioning live in `meta/`, with smoke tests in `meta/tests/`. macOS-specific Karabiner settings are under `osx-config/`. Treat `archive/` as reference material rather than active configuration.

## Build, Test, and Development Commands

- `make all` restows every active package. It is idempotent, but it updates symlinks in your home directory.
- `make pkg PKG=git` restows one package from `home/`; use `make unpkg PKG=git` to unlink it.
- `make uninstall` removes all managed links without deleting repository files.
- `bash meta/install.sh` runs the full platform-aware installation workflow.
- `bash meta/tests/locale.sh`, `bash meta/tests/install-shell.sh`, and `bash meta/tests/zsh-startup.sh` run the current smoke-test suite.

Run the three tests after changing installers, locale handling, Stow layout, or Zsh startup behavior. There is no separate build step.

## Coding Style & Naming Conventions

Shell scripts use Bash, begin with `#!/usr/bin/env bash`, and enable `set -euo pipefail`. Use two-space indentation, lowercase `snake_case` for functions and local variables, quoted expansions, and clear failure messages on stderr. Keep platform branches explicit (`Darwin`, Fedora/dnf, Ubuntu/apt). Lua follows `config/nvim/stylua.toml`: two spaces and a 120-column limit; format it with `stylua config/nvim`. Preserve the native syntax and established formatting of TOML, YAML, KDL, and application config files.

## Testing Guidelines

Tests are executable-style Bash scripts named for the behavior they cover, such as `meta/tests/zsh-startup.sh`. Keep tests isolated with `mktemp -d`, clean up with `trap`, and mock system commands instead of changing the host. Add regression coverage whenever installer or startup behavior changes. No numeric coverage target is defined.

## Commit & Pull Request Guidelines

Recent commits use short, imperative subjects such as `Update tmux config` and `Fix bootstrap and install scripts for cross-platform use`. Keep each commit focused; an optional `Fix:` prefix appears in history but is not required. Pull requests should describe the affected tools and platforms, list commands run, and call out migration or restow steps. Include screenshots only for visible terminal, editor, or macOS UI changes, and link related issues when applicable.

## Security & Local Configuration

Never commit credentials or machine-specific identity. Keep Git user data in `~/.gitconfig.local` and optional Zsh overrides in `~/.config/zsh/local.zsh`, as documented in `README.md`.
