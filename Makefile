DOTFILES := $(shell pwd)
STOW := stow -v

# home/ packages (stow -d home -t $HOME <pkg>)
HOME_PKGS := asdf git ruby tmux

# config/ is a single stow package (stow -t ~/.config config)
# All subdirs (fish, ghostty, lazygit, nvim, starship, delta) are stowed together.

# OS-specific home packages
ifeq ($(shell uname),Darwin)
  HOME_PKGS += aerospace
endif

.PHONY: all home config uninstall clean

all: home config

home:
	@echo "==> Stowing home packages to $$HOME"
	@for pkg in $(HOME_PKGS); do \
		$(STOW) -d home -t $(HOME) $$pkg; \
	done

config:
	@echo "==> Stowing config to ~/.config"
	$(STOW) -t $(HOME)/.config config

uninstall:
	@echo "==> Unstowing home packages"
	@for pkg in $(HOME_PKGS); do \
		$(STOW) -D -d home -t $(HOME) $$pkg; \
	done
	@echo "==> Unstowing config"
	$(STOW) -D -t $(HOME)/.config config

# Stow a single home package: make pkg PKG=git
pkg:
	$(STOW) -d home -t $(HOME) $(PKG)

# Unstow a single home package: make unpkg PKG=git
unpkg:
	$(STOW) -D -d home -t $(HOME) $(PKG)
