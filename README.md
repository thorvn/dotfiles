# Config \*Unix (macOS & ArchLinux)

## Screenshot

### MACOS

![Mac_Iterm2](.mac-iterm2.png)

### ARCH LINUX

![Arch_Screenshot](.arch_screenshot.png)

## Features

- Node version manager: fnm
- Ruby version manager: rbenv
- Recursively searches: ripgrep
- Shell: zsh & prezto framework
- Text editor: neovim
- Dotfiles manager: stow
- Terminal: kitty
- Tiling window manager: Yabai + skhd + sketchybar



## Install

To set up your development environment, run

```bash
  alias config='/usr/bin/git --git-dir=$HOME/.dotfiles/ --work-tree=$HOME'
  curl -sSL https://raw.githubusercontent.com/th0r/dotfiles/master/.scripts/install.sh | sh
```

## Notes

### Find colorschemes for iterm2

- https://iterm2colorschemes.com/
- https://github.com/MartinSeeler/iterm2-material-design
