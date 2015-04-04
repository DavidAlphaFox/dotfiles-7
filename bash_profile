#!/bin/bash

export PATH=~/.bin:$PATH

source ~/.bashrc

export TERM=xterm
export SSH_ASKPASS="/usr/lib/seahorse/seahorse-ssh-askpass"

# local machine settings
if [ -f ~/.bash_local ]; then
    . ~/.bash_local
fi

