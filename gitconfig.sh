#!/bin/sh

# Git configs that I want everywhere I work

# Correct line endings before pushing
git config --global core.autocrlf input

# Always show untracked files
git config --global status.showuntrackedfiles all

# Only push tracking branches
git config --global push.default tracking

# Nice diffstat from pull/rebase
git config --global rebase.stat true

# Nice colors
git config --global color.ui auto
git config --global core.pager "less -FRSX"

# Global .gitignore
git config --global core.excludesfile '~/.gitignore'
