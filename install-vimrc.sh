#!/bin/bash

# hack to make gvim work on win32
if [ $(uname -s | grep -c CYGWIN) -eq 1 ]; then
    rm -rf ~/vimfiles ~/.vimrc ~/.gvimrc ~/_vimrc
    cp -r ~/.vim/ ~/vimfiles
    cp ~/.vim/vimrc ~/.vimrc
    cp ~/.vim/gvimrc ~/.gvimrc
    cp ~/.vim/vimrc ~/_vimrc
else
    ln -fs ~/.vim/vimrc ~/.vimrc
    ln -fs ~/.vim/gvimrc ~/.gvimrc
fi
