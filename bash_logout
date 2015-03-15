#!/bin/bash

SSH_ENV="$HOME/.ssh-agent.`hostname`"
SSH_FIX_ENV="$HOME/.ssh-agent-fwd.`hostname`"

if [ -n "$SSH_AGENT_PID" ]; then
    # remove cached ssh keys
    ssh-add -D
    # shutdown ssh-agent
    eval `ssh-agent -k`
fi

if [ -f "${SSH_ENV}" ]; then
    # remove ssh-agent info
    rm "${SSH_ENV}"
fi

if [ -f "${SSH_FIX_ENV}" ]; then
    #remove ssh-agent fix info
    rm "${SSH_FIX_ENV}"
fi

# remove cached sudo credentials
#sudo -K

