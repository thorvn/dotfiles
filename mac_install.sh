# Install Homebrew
ruby -e "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/master/install)"
brew update
brew doctor
# Install oh-my-zsh
curl -L https://github.com/robbyrussell/oh-my-zsh/raw/master/tools/install.sh | sh
chsh -s $(which zsh)

brew install git
brew install p7zip
brew install neovim
brew install rbenv

rbenv init

brew install tmux
brew install python3
brew install yarn


brew install zsh-autosuggestions

# Install nvm
curl -o- https://raw.githubusercontent.com/creationix/nvm/v0.33.5/install.sh | bash

# Install lolcat
gem install lolcat



# linked apps
brew linkapps

echo "**Memory Clean** ..."
