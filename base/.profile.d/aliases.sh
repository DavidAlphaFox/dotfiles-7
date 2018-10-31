#!/bin/bash

alias df='df -h'
alias lt='tree -aFC -I .git'
alias pt='pstree -U'
alias pa='pt -al'
alias umbriel="nethack -u Umbriel-Hum-Mal-Pri-Law"
alias hat='highlight -q -O ansi -c stdout --force'
alias cp='cp --reflink=auto'
alias xz='xz --threads=0'
alias la='ls -AhF'
alias l='ls -hF'
alias pasnoop='pacmd list-sink-inputs | grep -e "media.name" -e spec; pacmd list-sinks | grep -e device.description -e spec'
alias gal='git all pull'
alias gas='git all status -sb'
alias garp='git all remote prune origin'
alias drmi="docker images | fzf-tmux -m --tac | awk '{print \$3}' | sort -u | xargs docker rmi"
alias fa='cat ~/Documents/fa_cheat.txt | grep -v Name | grep -i -B1 -e '
alias ncdu='ncdu --color dark'
alias yc='yay -Scc --noconfirm'

