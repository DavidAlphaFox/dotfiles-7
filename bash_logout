#!/bin/bash

SSH_ENV="$HOME/.ssh-agent.`hostname`"
SSH_FIX_ENV="$HOME/.ssh-agent-fwd.`hostname`"

if [ -n "$SSH_AGENT_PID" ]; then
    # remove cached ssh keys
    [[ -z "$MINTTY" ]] && note ssh-add -D
fi

if [ -f "${SSH_ENV}" ]; then
    # remove ssh-agent info
    rm -v "${SSH_ENV}"
fi

if [ -f "${SSH_FIX_ENV}" ]; then
    #remove ssh-agent fix info
    rm -v "${SSH_FIX_ENV}"
fi

