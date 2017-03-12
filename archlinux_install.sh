#!/bin/bash
#### Install Plug in Vim
curl -fLo ~/.local/share/nvim/site/autoload/plug.vim --create-dirs \
    https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim
#### Install Pathogen in Vim
mkdir -p ~/.vim/autoload ~/.vim/bundle && \
curl -LSso ~/.vim/autoload/pathogen.vim https://tpo.pe/pathogen.vim

# Install python
yaourt -S --noconfirm python
pacman -S --noconfirm python-pip

## Install Ruby
sudo pacman -S --noconfirm ruby

## Install Rails
gem install bundler --no-rdoc --no-ri
gem install rails --no-rdoc --no-ri


# Install lolcat
#gem install lolcat
#sudo pacman -S --noconfirm fortune-mod
#sudo pacman -S --noconfirm cowsay

#sudo pacman -S --noconfirm emacs httpie curl
#git clone https://github.com/syl20bnr/spacemacs ~/.emacs.d

yaourt -S --noconfirm tree wget
## Install Linux brew
#ruby -e "$(curl -fsSL https://raw.githubusercontent.com/Linuxbrew/install/master/install)"
## Update Brew
#cd "$(brew --repo)" && git fetch && git reset --hard origin/master && brew update
## Install Nodejs
#yaourt -S --noconfirm nodejs eslint

pacman -S --noconfirm zsh
sh -c "$(wget https://raw.githubusercontent.com/robbyrussell/oh-my-zsh/master/tools/install.sh -O -)"
## Install Oh My ZSH plugin
git clone git://github.com/zsh-users/zsh-autosuggestions $ZSH_CUSTOM/plugins/zsh-autosuggestions

## Install tmux
sudo pacman -S --noconfirm tmux

# ------ Install config ----- #
#cp arch/.Xmodmap ~
#cp arch/.xinitrc ~
cp .tmux.conf ~
cp .aliases ~
cp .functions ~
cp .zshrc ~
mkdir -p ~/.config/nvim 
cp init.vim ~/.config/nvim

echo -e  "\e[5m \e[33mConfig tmux, aliases, functions, oh my zsh, neovim DONE!!!"
