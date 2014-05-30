#!/bin/bash

FILES=( inputrc vim vimrc bashrc bash_profile ackrc Xmodmap zdir tmux.conf haskeline ghci)

gconftool-2 --load gnome-terminal-gconf.xml

for FILE in ${FILES[@]}; do
    if [ -e ~/.$FILE -o -L ~/.$FILE ]; then
        echo "~/.$FILE exists, skipping"
    else
        ln -s $PWD/$FILE ~/.$FILE
    fi
done
