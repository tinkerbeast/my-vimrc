# my-vimrc

The standard vimrc I use. This project is just for keeping an online copy and easy access from other workstataions.

## Installation

### Basic

    cd ~
    git clone https://github.com/tinkerbeast/my-vimrc.git .vim
    ln -s .vim/vimrc .vimrc

### Static plugins

    curl -LSso ~/.vim/autoload/pathogen.vim https://tpo.pe/pathogen.vim
    curl -LSso ~/.vim/plugin/cscope_maps.vim http://cscope.sourceforge.net/cscope_maps.vim

### Pathogen based plugins

    cd .vim
    git submodule update --init --recursive



