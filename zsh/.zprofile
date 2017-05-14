
# custom PATH
typeset -U path
path=(~/.local/bin $path[@])

# dircolors
eval `dircolors -b ~/.dircolors`

