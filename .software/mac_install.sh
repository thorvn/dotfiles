# Install Homebrew
ruby -e "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/master/install)"
brew update
brew doctor

# Install fish shell
brew install fish
chsh -s $(which fish)

# Install prezto
# git clone --recursive https://github.com/sorin-ionescu/prezto.git "${ZDOTDIR:-$HOME}/.zprezto"

brew install nvim
brew install starship
brew install fzf
brew install zoxide
brew install neovim
brew install ripgrep
brew install eza
brew install bat

brew install tmux
git clone https://github.com/tmux-plugins/tpm ~/.tmux/plugins/tpm

# Fix some error
# compaudit | xargs chmod g-w
echo "**Memory Clean** ..."
