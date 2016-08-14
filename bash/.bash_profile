export SSH_ASKPASS="/usr/lib64/seahorse/seahorse-ssh-askpass"
# source the users bashrc if it exists
if [ -f "${HOME}/.bashrc" ] ; then
  source "${HOME}/.bashrc"
fi
# source the users bash_local if it exists
if [ -f "${HOME}/.bash_local" ] ; then
  source "${HOME}/.bash_local"
fi
export LD_LIBRARY_PATH=.
if [[ "$PATH" != *"$HOME/bin"* ]]; then
    PATH="$HOME/bin:$PATH"
fi
TERM=xterm
eval `dircolors -b /etc/dircolors`

alias df='df -h'
alias cmd="cygstart -- cmd"
alias lt='tree -aFC -I .git'
alias pt='pstree'
alias pa='pt -al'
alias free="free -mt"
alias palette="xfce4-terminal --color-table"
alias gl="git log --decorate"
alias gp="git pull"
alias gs="git status"
alias gd="git diff --color"
alias gc="git commit"
alias ga="git add"
alias gcp="git gc --prune; git remote prune origin; git pull"
alias tmux="tmux -2"
alias xlogout="xfce4-session-logout"
alias nethack="nethack -u Umbriel"
source ~/.bash_aliases

export TERMINAL=xfce4-terminal
export SSH_AUTH_SOCK=/run/user/1000/keyring/ssh

