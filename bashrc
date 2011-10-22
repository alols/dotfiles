#
# ~/.bashrc
#

# If using Cygwin, these will have to be unset
if [ $OS ] && [ $OS == "Windows_NT" ]; then
    unset TMP
    unset TEMP
fi

# If not running interactively, don't do anything
[[ $- != *i* ]] && return

alias ls='ls --color=auto --group-directories-first'
alias l.='ls -d .*'
alias ll='ls -l'
alias la='ls -la'
alias rm='rm -i'
alias cp='cp -i'
alias mv='mv -i'
alias grep='grep --color'
alias egrep='egrep --color=auto'
alias fgrep='fgrep --color=auto'
alias vi='vim'
alias which='alias | /usr/bin/which --tty-only --read-alias --show-dot --show-tilde'

PS1='[\u@\h \W]\$ '

export HISTCONTROL=ignoredups
export HISTFILESIZE=10000
export HISTSIZE=$HISTFILESIZE
