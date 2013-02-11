#!/bin/sh
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

# xmledit
cd .vim/bundle/xmledit/ftplugin/
if [ `uname -s` == *CYGWIN* ]; then
   cp xml.vim html.vim
   cp xml.vim xhtml.vim
else
   ln -s xml.vim html.vim
   ln -s xml.vim xhtml.vim
fi
