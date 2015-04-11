#!/bin/bash

export PATH=~/.bin:$PATH

source ~/.bashrc

export TERM=xterm
export LC_ALL=C
export LANG=en_US.UTF-8
export LC_CTYPE=en_US.UTF-8
export LC_NUMERIC=en_US.UTF-8
export LC_TIME=en_US.UTF-8
export LC_COLLATE="C"
export LC_MONETARY=en_US.UTF-8
export LC_MESSAGES=en_US.UTF-8

if [ -z "$SSH_ASKPASS" ] && [ -n "$DISPLAY" ]; then
  export SSH_ASKPASS=/usr/lib/seahorse/seahorse-ssh-askpass
fi

# local machine settings
if [ -f ~/.bash_local ]; then
    . ~/.bash_local
fi

