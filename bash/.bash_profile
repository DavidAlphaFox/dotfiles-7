export SSH_ASKPASS="/usr/lib64/seahorse/seahorse-ssh-askpass"
# source the users bashrc if it exists
if [ -f "${HOME}/.bashrc" ] ; then
  source "${HOME}/.bashrc"
fi
export LD_LIBRARY_PATH=.
if [[ "$PATH" != *"$HOME/bin"* ]]; then
    PATH="$HOME/bin:$PATH"
fi
TERM=xterm
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
export CLUTTER_BACKEND=x11
eval `dircolors -b /etc/dircolors`
alias mysql="cmd /k mysql"
alias xlogout="xfce4-session-logout"
alias npm="cmd /K npm"
alias bower="cmd /K bower"

