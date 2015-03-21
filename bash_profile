#!/bin/bash

export PATH=~/.bin:$PATH

source ~/.bashrc
[[ -z $WINDOW ]] && source ~/.bash.d/bash_xwin
[[ -n $SSH_TTY ]] && source ~/.bash.d/bash_ssh

# local machine settings
if [ -f ~/.bash_local ]; then
    . ~/.bash_local
fi
[[ -z "$WINDOW" ]] && note ssh-add -l 
if [ "$PWD" = "$HOME" ]; then
    if [[ $(tty) != /dev/tty* ]]; then
        screen -UDRR -t " " 2>/dev/null && exit
    fi
fi
