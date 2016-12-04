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

## Install Ruby
sudo pacman -S ruby

## Install Linux brew
ruby -e "$(curl -fsSL https://raw.githubusercontent.com/Linuxbrew/install/master/install)"
## Update Brew
cd "$(brew --repo)" && git fetch && git reset --hard origin/master && brew update
## Install Nodejs
sudo yaourt -S --noconfirm nodejs


## Install Oh My ZSH plugin
git clone git://github.com/zsh-users/zsh-autosuggestions $ZSH_CUSTOM/plugins/zsh-autosuggestions
