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
alias q=exit
alias t=task

PS1='[\u@\h \W]\$ '

export HISTCONTROL=ignoredups
export HISTFILESIZE=10000
export HISTSIZE=$HISTFILESIZE

export EDITOR=vim
export VISUAL=vim

# Load z
. ~/.zdir/z.sh

# tmux borks vim without this, even though I only use 16 colors
if [ $TERM == "xterm" ]; then
    export TERM=xterm-256color
fi
