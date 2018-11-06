# help
autoload -Uz run-help
unalias run-help
alias help=run-help

# Load profiles from $HOME/.profile.d
if test -e "$HOME/.profile.d/"; then
    for profile in $HOME/.profile.d/*.sh; do
        test -r "$profile" && . "$profile"
    done
    unset profile
fi
# source a file not in git repo...
if [ -e "$HOME/.zlocal" ]; then
  source "$HOME/.zlocal"
fi
# shorter delay on cmd-mode
export KEYTIMEOUT=1
if [ -e "$HOME/go" ]; then
  GOPATH="$HOME/go"
  PATH="$PATH:$HOME/go/bin"
fi
if [ -e "/usr/share/fzf/key-bindings.zsh" ]; then
  export FZF_TMUX=1
  export FZF_DEFAULT_COMMAND='ag -f -g "" --hidden --depth 16 --ignore dosdevices'
  export FZF_DEFAULT_OPTS='-m --ansi --color=16,bg:-1,bg+:-1 --tac'
  export FZF_CTRL_T_COMMAND="$FZF_DEFAULT_COMMAND"
  export FZF_ALT_C_COMMAND="find -L . -maxdepth 16 -type d 2>/dev/null"
  source /usr/share/fzf/key-bindings.zsh
  source /usr/share/fzf/completion.zsh
fi

export GIT_TEMPLATE_DIR="$HOME/.git-templates/"

