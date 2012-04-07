#!/bin/bash

FILES=( Xresources inputrc vim vimrc bashrc bash_profile zdir muttrc mutt signature )

for FILE in ${FILES[@]}; do
    if [ -e ~/.$FILE -o -L ~/.$FILE ]; then
        echo "~/.$FILE exists, skipping"
    else
        ln -s $PWD/$FILE ~/.$FILE
    fi
done
