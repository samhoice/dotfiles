#!/bin/sh

#################### INITIAL STUFF #################### 

# test to see if this is macOS?

IS_MAC = true

SOURCEDIR=$(pwd)

#################### SETUP VIM #################### 
# dir
VIMDIR=$HOME/.vim
echo $VIMDIR
mkdir -p $VIMDIR
# swap
mkdir -p $VIMDIR/swap

# vimrc
ln -s -f $SOURCEDIR/vim/vimrc $VIMDIR/vimrc
# TODO: there's a bug here. you can't make links the same way on MacOS and Linux
# Update: I can't figure out why this wouldn't work. Might have to do with the -f/-F
# echo "linking vim/autoload/"
ln -s -f $SOURCEDIR/vim/autoload $VIMDIR/autoload
# echo "linking vim/ftplugin/"
ln -s -f $SOURCEDIR/vim/ftplugin $VIMDIR/ftplugin

# tmux
ln -s -f $SOURCEDIR/tmux.conf $HOME/.tmux.conf 
