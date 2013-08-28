#!/bin/bash
cd ..
# hack to make gvim work on win32
if [ `uname -s` == *CYGWIN* ]; then
   cp -r .vim/ vimfiles
   cp .vim/vimrc .vimrc
   cp .vim/gvimrc .gvimrc
else
   ln -s .vim/vimrc .vimrc
   ln -s .vim/gvimrc .gvimrc
fi
