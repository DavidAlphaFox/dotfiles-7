#!/bin/bash

SSH_FIX_ENV="$HOME/.ssh-agent-fwd.`hostname`"

if [ -f "${SSH_FIX_ENV}" ]; then
    #remove ssh-agent fix info
    rm -v "${SSH_FIX_ENV}"
fi

