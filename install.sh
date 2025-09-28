#!/bin/sh
rm -f ~/.vimrc
ln -s $PWD/.vimrc ~/.vimrc

printf "\e[32m The vim configuration is ready to go!\e[0m\n"

# vim -e PlugInstall
#
