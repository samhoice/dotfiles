#!/bin/sh

SOURCEDIR=$(pwd)
VIMDIR=$HOME/.vim

echo $VIMDIR

mkdir -p $VIMDIR
mkdir -p $VIMDIR/swap

# vim
echo "linking vimrc"
ln -s -f $SOURCEDIR/vim/vimrc $VIMDIR/vimrc
# TODO: there's a bug here. you can't make links the same way on MacOS and Linux
# This might be a good case for switching to ansible
# echo "linking vim/autoload/"
ln -s -f $SOURCEDIR/vim/autoload $VIMDIR/autoload
# echo "linking vim/ftplugin/"
ln -s -f $SOURCEDIR/vim/ftplugin $VIMDIR/ftplugin

# tmux
ln -s -f $SOURCEDIR/tmux.conf $HOME/.tmux.conf 
