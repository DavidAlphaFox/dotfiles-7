source /usr/share/zsh/share/antigen.zsh

# oh-my-zsh plugins
antigen use oh-my-zsh

# various bundles
antigen bundle git
antigen bundle colored-man-pages
antigen bundle zsh-users/zsh-autosuggestions
antigen bundle bric3/nice-exit-code
antigen bundle zsh-users/zsh-completions
antigen bundle zsh-users/zsh-syntax-highlighting

# all done with antigen
antigen apply
# help
autoload -Uz run-help
unalias run-help
alias help=run-help

# spellcheck commands
setopt correct

# vi mode
bindkey -v

# backspace
bindkey -a '^?' vi-backward-delete-char
# home
bindkey -a '\e[1~' vi-first-non-blank
bindkey '\e[1~' vi-first-non-blank
# insert
bindkey -a '\e[2~' vi-insert
bindkey '\e[2~' vi-insert # noop?
# delete
bindkey '\e[3~' vi-delete-char
bindkey -a '\e[3~' vi-delete-char
# end
bindkey -a '\e[4~'  vi-end-of-line
bindkey '\e[4~'  vi-end-of-line
# complete word
bindkey '^w' vi-forward-word

# better auto-suggest
my-autosuggest-accept() {
    zle autosuggest-accept
    zle redisplay
    zle redisplay
}
zle -N my-autosuggest-accept
ZSH_AUTOSUGGEST_IGNORE_WIDGETS+=my-autosuggest-accept
bindkey '^ ' my-autosuggest-accept
ZSH_AUTOSUGGEST_ACCEPT_WIDGETS=''
ZSH_AUTOSUGGEST_PARTIAL_ACCEPT_WIDGETS+=vi-forward-char
ZSH_AUTOSUGGEST_STRATEGY=match_prev_cmd

# Load profiles from ~/.profile.d
if test -e ~/.profile.d/; then
    for profile in ~/.profile.d/*.sh; do
        test -r "$profile" && . "$profile"
    done
    unset profile
fi
# source a file not in git repo...
if [ -e "~/.zlocal" ]; then
  source ~/.zlocal
fi
# shorter delay on cmd-mode
export KEYTIMEOUT=1
antigen bundle hlissner/zsh-autopair
if [ -e "/usr/share/nvm/init-nvm.sh" ]; then
  source /usr/share/nvm/init-nvm.sh
fi
if [ -e "$HOME/go/bin" ]; then
  GOPATH="$HOME/go"
  PATH="$PATH:${GOPATH}/bin"
fi
if [ -e "$HOME/.opam/opam-init/init.zsh" ]; then
  . ~/.opam/opam-init/init.zsh > /dev/null 2> /dev/null || true
fi
if [ -e "$HOME/go" ]; then
  PATH="$PATH:$HOME/go/bin"
fi
