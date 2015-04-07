#!/bin/bash

export PATH=~/.bin:$PATH

source ~/.bashrc

export TERM=xterm
if [ -z "$SSH_ASKPASS" ] && [ -n "$DISPLAY" ]; then
  export SSH_ASKPASS=/usr/lib/seahorse/seahorse-ssh-askpass
fi

# local machine settings
if [ -f ~/.bash_local ]; then
    . ~/.bash_local
fi

