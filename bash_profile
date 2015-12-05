
# source the users bashrc if it exists
if [ -f "${HOME}/.bashrc" ] ; then
  source "${HOME}/.bashrc"
fi

if [[ "$PATH" != *"dotfiles"* ]]; then
    PATH="$HOME/.dotfiles/bin:$PATH"
fi

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

