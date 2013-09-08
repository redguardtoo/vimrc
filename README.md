Chen Bin (redguardtoo)'s vimrc
===================
* Author: Chen Bin
* Github: git://github.com/redguardtoo/vimrc.git
* gvim on WIN32 works if you set the $HOME environment variable
* NO Ruby/Python/Perl dependency. The only programming language except native vim script I can accept is C
* This vimrc is light weight because I'm [Emacs user now](https://github.com/redguardtoo/emacs.d)
* I do not use "git submodule".

INSTALL ON LINUX
--------------------

git clone https://github.com/redguardtoo/vimrc.git ~/.vim;cd ~/.vim;./install-vimrc.sh

INSTALL ON WINDOWS IN EASY WAY (RECOMMENDED)
-----------------------------------------------------
1. Install CYGWIN
2. In CYGWIN bash shell, run exact command as "INSTALL ON LINUX" section.
3. Set the value of environment variable "HOME" to the full path of parent directory of .vim

INSTALL ON WINDOWS
---------------------------

1. Check out from github

cd C:\Program Files\Vim   (or your installed path to Vim)
rmdir /s vimfiles         (This deletes your old vim configurations. If you want to keep it, use move instead of rmdir.)
git clone https://github.com/redguardtoo/vimrc.git vimfiles

2. Install vimrc. Add the following line at the end of C:\Program Files\Vim\vimrc.

source $VIM/vimfiles/vimrc


PLUGINS
-------

* [Pathogen](http://www.vim.org/scripts/script.php?script_id=2332): Pathogen let us install a plugin as a bundle in ~/.vim/bundle seprately.

* [Nerd Tree](http://www.vim.org/scripts/script.php?script_id=1658): A tree explorer plugin for navigating the filesystem.

  Useful commands:
    `:Bookmark [name]` - bookmark any directory as name
    `:NERDTree [name]` - open the bookmark [name] in Nerd Tree

* [NERD commenter](http://www.vim.org/scripts/script.php?script_id=1218): Press ",ci" or ",cc" to comment/uncomment lines

* [AutoClose](http://www.vim.org/scripts/script.php?script_id=1849):  Inserts matching bracket, paren, brace or quote.

* [vim-surround](https://github.com/tpope/vim-surround/blob/master/doc/surround.txt): deal with pairs of surroundings.

* [matchit](http://www.vim.org/scripts/script.php?script_id=39): extended % matching for HTML, LaTeX, and many other languages. 

* [YankRing](http://www.vim.org/scripts/script.php?script_id=1234): Maintains a history of previous yanks, changes and deletes 
  
  `:help yankring` to see more info.

Other good references
---------------------

* http://amix.dk/vim/vimrc.html
* http://spf13.com/post/perfect-vimrc-vim-config-file
