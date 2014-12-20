#!/bin/bash

FILES=( inputrc vim vimrc bashrc bash_profile ackrc Xmodmap zdir tmux.conf haskeline ghci gitignore )

# gnome-terminal-gconf.xml was created with the command
# gconftool-2 --dump /apps/gnome-terminal/profiles > .dotfiles/gnome-terminal-gconf.xml
gconftool-2 --load gnome-terminal-gconf.xml

for FILE in ${FILES[@]}; do
    if [ -e ~/.$FILE -o -L ~/.$FILE ]; then
        echo "~/.$FILE exists, skipping"
    else
        ln -s $PWD/$FILE ~/.$FILE
    fi
done
