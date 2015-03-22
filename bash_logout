#!/bin/bash

SSH_ENV="$HOME/.ssh-agent.`hostname`"
SSH_FIX_ENV="$HOME/.ssh-agent-fwd.`hostname`"

if [ -f "${SSH_FIX_ENV}" ]; then
    #remove ssh-agent fix info
    rm "${SSH_FIX_ENV}"
fi

# remove cached sudo credentials
sudo -K

