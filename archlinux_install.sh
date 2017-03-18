#!/bin/bash

#echo "
#[archlinuxfr]
#SigLevel = Never
#Server = http://repo.archlinux.fr/$arch" >> /etc/pacman.conf 
# sudo pacman -Sy --noconfirm yaourt


#### Install Plug in Vim
curl -fLo ~/.local/share/nvim/site/autoload/plug.vim --create-dirs \
    https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim
#### Install Pathogen in Vim
#mkdir -p ~/.vim/autoload ~/.vim/bundle && \
#curl -LSso ~/.vim/autoload/pathogen.vim https://tpo.pe/pathogen.vim

# Config network

sudo pacman -S --noconfirm net-tools network-manager-applet
sudo systemctl stop dhcpcd@ens33.service
sudo systemctl disable dhcpcd@ens33.service
sudo systemctl stop dhcpcd.service
sudo systemctl disable dhcpcd.service
sudo systemctl start NetworkManager
sudo systemctl enable NetworkManager

sudo pacman -S --noconfirm  httpie curl wget neovim firefox p7zip tmux  xfce4-screenshooter os-prober openssh 
sudo grub-mkconfig -o /boot/grub/grub.cfg
mkdir -p ~/.ssh

gpg --keyserver hkp://keys.gnupg.net --recv-keys 409B6B1796C275462A1703113804BB82D39DC0E3
\curl -sSL https://get.rvm.io | bash

# Install python
pacman -S --noconfirm python
pacman -S --noconfirm python-pip


## Install Rails
gem install bundler --no-rdoc --no-ri
gem install rails --no-rdoc --no-ri


# Install lolcat
#gem install lolcat
#sudo pacman -S --noconfirm fortune-mod
#sudo pacman -S --noconfirm cowsay

#git clone https://github.com/syl20bnr/spacemacs ~/.emacs.d

yaourt -S --noconfirm tree broadcom-wl pamac-aur imgur-screenshot-git
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


## Notes
# View list nvidia
# sudo pacman -Ss | grep nvidia
# sudo pacman -S nvidia
# sudo pacman -S nvidia-settings

# ------ Install config ----- #
#cp arch/.Xmodmap ~
#cp arch/.xinitrc ~
cp .tmux.conf ~
cp .aliases ~
cp .functions ~
cp .zshrc ~
mkdir -p ~/.config/nvim
cp init.vim ~/.config/nvim

echo -e  "\e[33mConfig tmux, aliases, functions, oh my zsh, neovim DONE!!!"
