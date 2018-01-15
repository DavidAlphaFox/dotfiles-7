#!/bin/sh

VBoxClient-all
# x config values
xrdb "${HOME}/.Xresources"
# root background image
if [ -f "${HOME}/.fehbg" ]; then
  ~/.fehbg
else
  feh --bg-fill "${HOME}/Pictures/bg.png"
fi
# compositor
compton -b
# terminal service
urxvtd -q -o -f
# window manager
exec i3

