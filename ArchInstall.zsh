#!/bin/bash
#### Install Plug in Vim
curl -fLo ~/.vim/autoload/plug.vim --create-dirs \
    https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim
#### Install Pathogen in Vim
mkdir -p ~/.vim/autoload ~/.vim/bundle && \
curl -LSso ~/.vim/autoload/pathogen.vim https://tpo.pe/pathogen.vim
#### Install theme in Vim
git clone git://github.com/altercation/vim-colors-solarized.git ~/.vim/bundle/vim-colors-solarized

cp config/vim/.vimrc ~/.vimrc

# Install python
yaourt -S --noconfirm python
pacman -S --noconfirm python-pip

# Install neovim
sudo pip3 install neovim

## Install Ruby
sudo pacman -S --noconfirm ruby

## Install Rails
gem install bundler --no-rdoc --no-ri
gem install rails --no-rdoc --no-ri


# Install lolcat
gem install lolcat
sudo pacman -S --noconfirm fortune-mod
sudo pacman -S --noconfirm cowsay

sudo pacman -S --noconfirm emacs httpie curl
git clone https://github.com/syl20bnr/spacemacs ~/.emacs.d

yaourt -S --noconfirm tree
## Install Linux brew
#ruby -e "$(curl -fsSL https://raw.githubusercontent.com/Linuxbrew/install/master/install)"
## Update Brew
#cd "$(brew --repo)" && git fetch && git reset --hard origin/master && brew update
## Install Nodejs
yaourt -S --noconfirm nodejs eslint

## Install Oh My ZSH plugin
git clone git://github.com/zsh-users/zsh-autosuggestions $ZSH_CUSTOM/plugins/zsh-autosuggestions

## Install tmux
sudo pacman -S --noconfirm tmux

# ------ Install config ----- #
cp arch/.Xmodmap ~
cp arch/.xinitrc ~
cp .tmux.conf ~
cp .aliases ~
cp .functions ~

