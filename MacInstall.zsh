# Install Homebrew
ruby -e "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/master/install)"
brew update
brew doctor
# Install oh-my-zsh
curl -L https://github.com/robbyrussell/oh-my-zsh/raw/master/tools/install.sh | sh
chsh -s $(which zsh)

# Install dropbox
brew cask install dropbox

# Install lolcat
gem install lolcat

# Resore mackup
read -p "Make sure Dropbox has sync all settings. Press any key to continue......"
mackup restore

# linked apps
brew linkapps

echo "**Memory Clean** ..."
