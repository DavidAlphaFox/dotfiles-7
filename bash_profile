#!/bin/bash

export PATH=~/.bin:$PATH
export TERM=xterm

source ~/.bashrc

# local machine settings
if [ -f ~/.bash_local ]; then
    . ~/.bash_local
fi

[[ -z $DISPLAY ]] && [[ $(tty) = /dev/tty1 ]] && source ~/.bash.d/bash_tty
[[ -n $DISPLAY ]] && source ~/.bash.d/bash_xwin
[[ -n $SSH_TTY ]] && source ~/.bash.d/bash_ssh
