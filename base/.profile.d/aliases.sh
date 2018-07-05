#!/bin/bash

alias df='df -h'
alias lt='tree -aFC -I .git'
alias pt='pstree -U'
alias pa='pt -al'
alias umbriel="nethack -u Umbriel-Hum-Mal-Pri-Law"
alias hat='highlight -q -O ansi -c stdout --force'
alias cp='cp --reflink=auto'
alias la='ls -AhF'
alias l='ls -hF'
alias pasnoop='pacmd list-sink-inputs | grep -e "media.name" -e spec; pacmd list-sinks | grep -e device.description -e spec'
alias gal='git all pull'
alias gas='git all status -sb'
alias drmi="docker images | fzf -m --tac | awk '{print \$3}' | xargs docker rmi"
