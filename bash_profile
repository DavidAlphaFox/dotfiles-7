#!/bin/bash

export PATH=~/.bin:$PATH

if [ "$PWD" != "$HOME" ]; then
    export MINTTY=true
fi

source ~/.bashrc

[[ -z "$MINTTY" ]] && source ~/.bash.d/bash_xwin
[[ -n "$SSH_TTY" ]] && source ~/.bash.d/bash_ssh

# local machine settings
if [ -f ~/.bash_local ]; then
    . ~/.bash_local
fi

if [ -z "$MINTTY" ]; then
    note ssh-add -l
    if [[ $(tty) != /dev/tty* ]]; then
        screen -UDRR -t " " 2>/dev/null && exit
    fi
fi
