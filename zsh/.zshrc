PATH="$PATH:$HOME/.local/bin"
EDITOR=vim
PAGER=less
source ~/.antigen.zsh

# oh-my-zsh plugins
antigen use oh-my-zsh

# various bundles
antigen bundle git
antigen bundle colored-man-pages
antigen bundle zsh-users/zsh-autosuggestions
#antigen bundle bric3/nice-exit-code
antigen bundle zsh-users/zsh-completions
antigen bundle zsh-users/zsh-syntax-highlighting
#antigen theme eastwood
#antigen theme mrtazz
antigen theme terminalparty
#antigen theme sorin

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
bindkey -a "${terminfo[khome]}" vi-first-non-blank
bindkey "${terminfo[khome]}" vi-first-non-blank

# insert
bindkey -a '\e[2~' vi-insert
bindkey '\e[2~' vi-insert # noop?
# delete
bindkey '\e[3~' vi-delete-char
bindkey -a '\e[3~' vi-delete-char
# end
bindkey -a '\e[4~'  vi-end-of-line
bindkey '\e[4~'  vi-end-of-line
bindkey -a "${terminfo[kend]}" vi-end-of-line
bindkey "${terminfo[kend]}" vi-end-of-line

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

# shorter delay on cmd-mode
export KEYTIMEOUT=1

antigen bundle hlissner/zsh-autopair

if [ -e "/usr/share/nvm/init-nvm.sh" ]; then
  source /usr/share/nvm/init-nvm.sh
fi

# syntax highlighting
export ZSH_AUTOSUGGEST_HIGHLIGHT_STYLE='fg=black,bold'
export ZSH_HIGHLIGHT_HIGHLIGHTERS=(main brackets cursor)
export ZSH_HIGHLIGHT_STYLES[cursor]='fg=yellow,bold'
export ZSH_HIGHLIGHT_STYLES[unknown-token]='fg=red'
export ZSH_HIGHLIGHT_STYLES[path]='fg=blue,bold'
export ZSH_HIGHLIGHT_STYLES[path_prefix]='fg=blue'
export ZSH_HIGHLIGHT_STYLES[globbing]='fg=cyan,bold'
export ZSH_HIGHLIGHT_STYLES[single-quoted-argument]='fg=yellow'
export ZSH_HIGHLIGHT_STYLES[double-quoted-argument]='fg=yellow,bold'
export ZSH_HIGHLIGHT_STYLES[dollar-double-quoted-argument]='fg=red,bold,underline'
export ZSH_HIGHLIGHT_STYLES[command]='fg=green,bold'
export ZSH_HIGHLIGHT_STYLES[alias]='fg=green'
export ZSH_HIGHLIGHT_STYLES[builtin]='fg=magenta,bold'
export ZSH_HIGHLIGHT_STYLES[commandseparator]='fg=magenta'
export ZSH_HIGHLIGHT_STYLES[redirection]='fg=magenta'
export ZSH_HIGHLIGHT_STYLES[arg0]='fg=magenta'
export ZSH_HIGHLIGHT_STYLES[reserved-word]='fg=magenta'
export ZSH_HIGHLIGHT_STYLES[bracket-level-1]='fg=magenta,bold'
export ZSH_HIGHLIGHT_STYLES[bracket-level-2]='fg=blue,bold'
export ZSH_HIGHLIGHT_STYLES[bracket-level-3]='fg=green,bold'
export ZSH_HIGHLIGHT_STYLES[bracket-level-4]='fg=cyan,bold'
export ZSH_HIGHLIGHT_STYLES[bracket-level-5]='fg=red'
export ZSH_HIGHLIGHT_STYLES[cursor-matchingbracket]='fg=yellow,bold'
export ZSH_HIGHLIGHT_STYLES[single-hyphen-option]='fg=green'
export ZSH_HIGHLIGHT_STYLES[double-hyphen-option]='fg=green,bold'

alias l="ls -FG"
alias ll="ls -AlFGh"
alias la="ls -AFG"
# Umbriel: Chaotic Elven Priest
alias umbriel="nethack -u Umbriel-Elf-Mal-Pri-Cha"

