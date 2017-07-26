# Install basic software
sudo apt-get -y install curl zsh libpq-dev nodejs python3-pip python3-pip fcitx-unikey terminator xclip


# Install oh my zsh
sh -c "$(curl -fsSL https://raw.githubusercontent.com/robbyrussell/oh-my-zsh/master/tools/install.sh)"

# Install oh my zsh plugin
git clone git://github.com/zsh-users/zsh-autosuggestions $ZSH_CUSTOM/plugins/zsh-autosuggestions


# install rvm
gpg --keyserver hkp://keys.gnupg.net --recv-keys 409B6B1796C275462A1703113804BB82D39DC0E3 7D2BAF1CF37B13E2069D6956105BD0E739499BDB
\curl -sSL https://get.rvm.io | bash -s stable --ruby

# install rails development
sudo apt-get -y install postgresql postgresql-contrib
gem install rails

sudo apt-get -y install git-flow

# Install neovim
pip3 install neovim
pip install neovim
gem install neovim

# Config extend monitor
xrandr | grep 'HDMI1 connected' &&
    xrandr --output eDP1 --auto --output HDMI1 --auto --right-of eDP1

