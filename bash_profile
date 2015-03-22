#!/bin/bash

export PATH=~/.bin:$PATH

if [ "$PWD" != "$HOME" ]; then
    export MINTTY=true
fi

source ~/.bashrc

export TERM=xterm

# local machine settings
if [ -f ~/.bash_local ]; then
    . ~/.bash_local
fi

if [ -z "$MINTTY" ]; then
    if [[ $(tty) != /dev/tty* ]]; then
        screen -UDRR -t " " 2>/dev/null && exit
    fi
fi
