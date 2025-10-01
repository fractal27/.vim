#!/bin/sh

cp $HOME/.vimrc .vimrc.old
ln -s $PWD/.vimrc $HOME/.vimrc

printf "\e[32m The vim configuration is ready to go!\e[0m\n"

# vim -e PlugInstall
#
