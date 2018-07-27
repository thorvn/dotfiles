git clone --bare https://github.com/kensupermen/dotfiles $HOME/.dotfiles

mkdir -p .dotfiles-backup
config checkout
if [ $? = 0 ]; then
  echo "Checked out config.";
  else
    echo "Backing up pre-existing dot files.";
    config checkout 2>&1 | egrep "\s+\." | awk {'print $1'} | xargs -I{} mv {} .dotfiles-backup/{}
fi;

config checkout
config config status.showUntrackedFiles no

if [ ! -d "$HOME/.config/nvim" ]; then
  mkdir -p $HOME/.config/nvim
fi
cp $HOME/.init.vim $HOME/.config/nvim/init.vim

# Install vim plug for neovim
curl -fLo ~/.local/share/nvim/site/autoload/plug.vim --create-dirs \
      https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim

# Neovim dependencies
sudo apt-get install python-dev python-pip python3-dev python3-pip

source $HOME/.zshrc
echo "Everything done!!!"
