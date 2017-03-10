#!/bin/bash

export SSH_ASKPASS="/usr/lib64/seahorse/seahorse-ssh-askpass"
if hash gnome-keyring-daemon 2>/dev/null; then
  export SSH_AUTH_SOCK="/run/user/1000/keyring/ssh"
fi
