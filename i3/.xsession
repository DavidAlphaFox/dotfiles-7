#!/bin/sh

# x config values
xrdb "${HOME}/.Xresources"
# root background image
feh --bg-fill "${HOME}/Pictures/bg.png"
# compositor
compton -b
# terminal service
urxvtd -q -o -f
# window manager
exec i3

