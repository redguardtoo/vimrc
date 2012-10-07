#!/bin/sh
cd ..
# hack to make gvim work on win32
cp -r .vim/ vimfiles
cp .vim/vimrc .vimrc
cp .vim/gvimrc .gvimrc

# xmledit
cd .vim/bundle/xmledit/ftplugin/
cp xml.vim html.vim
cp xml.vim xhtml.vim
