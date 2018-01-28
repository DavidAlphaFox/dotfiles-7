#!/bin/sh

VBoxClient-all
# x config values
xrdb "${HOME}/.Xresources"
# compositor
#compton -b
# terminal service
#urxvtd -q -o -f
# window manager
# root background image
#if [ -f "${HOME}/.fehbg" ]; then
#  ~/.fehbg
#else
#  feh --bg-fill /usr/local/share/wallpapers/default.png
#fi
#exec i3
exec fvwm
