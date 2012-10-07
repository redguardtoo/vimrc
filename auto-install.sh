#!/bin/sh
VIMHOME=~/.vim

warn() {
    echo "$1" >&2
}

die() {
    warn "$1"
    exit 1
}

# just override original file
#[ -e "$VIMHOME/vimrc" ] && die "$VIMHOME/vimrc already exists."
#[ -e "~/.vim" ] && die "~/.vim already exists."
#[ -e "~/.vimrc" ] && die "~/.vimrc already exists."

git clone git://github.com/vgod/vimrc.git "$VIMHOME"
cd "$VIMHOME"
git submodule update --init

./install-vimrc.sh

echo "chen's vimrc is installed."
