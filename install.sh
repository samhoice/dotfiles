#!/bin/sh

SOURCEDIR=$(pwd)
VIMDIR=$HOME/.vim

echo $VIMDIR

echo "linking vimrc"
ln -s -f $SOURCEDIR/vim/vimrc $VIMDIR/vimrc

echo "linking vim/autoload/"
ln -s -f $SOURCEDIR/vim/autoload $VIMDIR/autoload
echo "linking vim/ftplugin/"
ln -s -f $SOURCEDIR/vim/ftplugin $VIMDIR/ftplugin
