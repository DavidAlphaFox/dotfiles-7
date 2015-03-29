#!/bin/bash

# If not running interactively, don't do anything
case $- in
    *i*) ;;
      *) return;;
esac

if [ "$(uname -o)" = "Cygwin" ]; then
    export CYGWIN=true
fi

export EDITOR="vim"
export GIT_EDITOR=$EDITOR
export PAGER=less
export LANG=en_US.UTF-8
export LC_CTYPE="en_US.UTF-8"

# don't put duplicate lines or lines starting with space in the history.
HISTCONTROL=ignoreboth

# append to the history file, don't overwrite it
shopt -s histappend

# force historical multi-line commands to one line
shopt -s cmdhist

# for setting history length see HISTSIZE and HISTFILESIZE in bash(1)
HISTSIZE=2048
HISTFILESIZE=2048

# truncate working directory in prompts
PROMPT_DIRTRIM=3

# turn off flow-control
[ -z "$CYGWIN" ] && stty -ixon

# check the window size after each command and, if necessary,
# update the values of LINES and COLUMNS.
shopt -s checkwinsize

# If set, the pattern "**" used in a pathname expansion context will
# match all files and zero or more directories and subdirectories.
shopt -s globstar

# make less more friendly for non-text input files, see lesspipe(1)
[ -x /usr/bin/lesspipe ] && eval "$(SHELL=/bin/sh lesspipe)"

# enable color support of ls and also add handy aliases
if [ -x /usr/bin/dircolors ]; then
    test -r ~/.dircolors && eval "$(dircolors -b ~/.dircolors)" || eval "$(dircolors -b)"
fi

# keep bash aliases in a separate file
if [ -f ~/.bash.d/bash_aliases ]; then
    . ~/.bash.d/bash_aliases
fi

# enable programmable completion features
if ! shopt -oq posix; then
    if [ -f /usr/share/bash-completion/bash_completion ]; then
      . /usr/share/bash-completion/bash_completion
    elif [ -f /etc/bash_completion ]; then
      . /etc/bash_completion
    fi
fi

# git prompt functions
if [ -f ~/.bash.d/gitprompt ]; then
    . ~/.bash.d/gitprompt
fi

# local machine settings
if [ -f ~/.bash_localrc ]; then
    . ~/.bash_localrc
fi

# mintty title
echo -ne "\033]0;\007"

# prompt settings
export PS2=" \`if [ \$? = 0 ]; then echo $T_COLOR; else echo $F_COLOR; fi\`. \[\e[m\]"
PROMPT_COMMAND='. $HOME/.bash.d/bash_cmd; __git_ps1 " $W_COLOR\w\[\e[m\] " "\`if [ \$? = 0 ]; then echo \"$T_COLOR\"; else echo \"$F_COLOR\"; fi\`\[\e[m\]"'
