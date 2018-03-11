git clone --separate-git-dir=$HOME/.dotfiles https://github.com/kensupermen/dotfiles $HOME/dotfiles-tmp
rm -rf ~/dotfiles-tmp/

# Install vim plug for neovim
curl -fLo ~/.local/share/nvim/site/autoload/plug.vim --create-dirs \
      https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim

source $HOME/.zshrc
echo "Everything done!!!"
