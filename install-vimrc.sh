#!/bin/bash

# hack to make gvim work on win32
if [ $(uname -s | grep -c CYGWIN) -eq 1 ]; then
   cp -r ~/.vim/ ~/vimfiles
   cp ~/.vim/vimrc ~/.vimrc
   cp ~/.vim/gvimrc ~/.gvimrc
else
   ln -fs ~/.vim/vimrc ~/.vimrc
   ln -fs ~/.vim/gvimrc ~/.gvimrc
fi
