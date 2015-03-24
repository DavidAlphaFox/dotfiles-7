#!/bin/bash

export PATH=~/.bin:$PATH

source ~/.bashrc

export TERM=xterm

# local machine settings
if [ -f ~/.bash_local ]; then
    . ~/.bash_local
fi

