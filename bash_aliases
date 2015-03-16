#!/bin/bash

alias ls='ls --color=auto'
alias grep='grep --color=auto'
alias fgrep='fgrep --color=auto'
alias egrep='egrep --color=auto'
alias ll='ls -AlhF'
alias la='ls -AF'
alias l='ls -F'
alias lt='tree -aFL 1'
alias df='df -h'
alias pl='ps -eHo pid,tty,user,args'
alias p='pl c'
alias pt='pstree'
alias pa='pt -a'
alias bs="source ~/.bashrc"
alias git-include="git config --file ~/.gitinclude"
alias alert='notify-send --urgency=low -i "$([ $? = 0 ] && echo terminal || echo error)" "$(history|tail -n1|sed -e '\''s/^\s*[0-9]\+\s*//;s/[;&|]\s*alert$//'\'')"'
alias free="free -mt"
alias less=$PAGER
alias zless=$PAGER
alias st="screen-title"
alias say="notify-send -i 'anki' '$HOSTNAME'"
vim_w3m() {
    vim -c ":W3m $@" 
}
alias w3m=vim_w3m

