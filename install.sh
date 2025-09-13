#!/bin/sh

cp $HOME/.vimrc .vimrc.tmp
cp .vimrc $HOME/.vimrc

vim -e PlugInstall
