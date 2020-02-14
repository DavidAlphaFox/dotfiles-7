# .zshrc
typeset -U PATH path
path=(~/go/bin $path[@])
path=(~/.local/bin $path[@])
path=(~/.npm-global/bin $path[@])
export GOPATH="$HOME/go"
export NPM_CONFIG_CACHE="/tmp/.cache-$USER/npm"
export YARN_CACHE_FOLDER="/tmp/.cache-$USER/npm"
alias lt='tree -aFC -I .git'
alias pt='pstree -U'
alias hat='highlight -q -O ansi -c stdout --force'
alias pasnoop='pacmd list-sink-inputs | grep -e "media.name" -e spec; pacmd list-sinks | grep -e device.description -e spec'
alias drmi="docker images | fzf-tmux -m --tac | awk '{print \$3}' | sort -u | xargs docker rmi -f"
alias fa='cat ~/Documents/fa_cheat.txt | grep -v Name | grep -i -B1 -e '
alias sil='sil -mgcu'
