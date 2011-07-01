#!/bin/bash

FILES=( vim inputrc vimrc bashrc bash_profile )

for FILE in ${FILES[@]}; do
    if [ -e ~/.$FILE -o -L ~/.$FILE ]; then
        echo "~/.$FILE exists, skipping"
    else
        ln -s $PWD/$FILE ~/.$FILE
    fi
done
