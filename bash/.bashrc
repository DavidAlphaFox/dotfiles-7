
# If not running interactively, don't do anything
[[ "$-" != *i* ]] && return

export EDITOR=vim
export GIT_EDITOR=$EDITOR
export BROWSER=/usr/bin/chromium
export VISUAL="vim"
export SSH_AUTH_SOCK=/run/user/1000/keyring/ssh
