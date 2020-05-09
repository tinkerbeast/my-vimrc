# my-vimrc

The standard vimrc I use. This project is just for keeping an online copy and easy access from other workstataions.

## Installation

### Basic

    cd ~
    git clone https://github.com/tinkerbeast/my-vimrc.git .vim
    ln -s .vim/vimrc .vimrc

### Static plugins

    mkdir -p ~/.vim/autoload/
    mkdir -p ~/.vim/plugin/
    curl -fLo ~/.vim/autoload/plug.vim https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim
    curl -fLo ~/.vim/plugin/cscope_maps.vim http://cscope.sourceforge.net/cscope_maps.vim

### Plug base plugins

    :PlugInstall



