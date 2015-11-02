
# source the users bashrc if it exists
if [ -f "${HOME}/.bashrc" ] ; then
  source "${HOME}/.bashrc"
fi

#!/bin/bash

alias ls='ls --color=auto'
alias grep='grep --color=auto'
alias fgrep='fgrep --color=auto'
alias egrep='egrep --color=auto'
alias l='ls -h -F --color'
alias la='l -A'
alias ll='la -l'
alias df='df -h'
alias cmd="cygstart -- cmd"
alias lt='tree -aFC -I .git'
alias pt='pstree'
alias pa='pt -al'
alias free="free -mt"
alias palette="xfce4-terminal --color-table"
alias gl="git log --decorate"
alias gp="git pull"
alias gs="git status"
alias gd="git diff --color"
alias gc="git commit"
alias ga="git add"

