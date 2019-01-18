
# Load profiles from $HOME/.profile.d
if test -e "$HOME/.profile.d/"; then
    for profile in $HOME/.profile.d/*.sh; do
        test -r "$profile" && . "$profile"
    done
    unset profile
fi

export GIT_TEMPLATE_DIR="$HOME/.git-templates/"
typeset -U path
path=(~/.local/bin $path[@])
path=(~/.npm-global/bin $path[@])
export EDITOR=nvim

