#!/bin/sh

/usr/local/bin/VBoxClient --display
# x config values
xrdb "${HOME}/.Xresources"
# compositor
compton -b
/usr/local/bin/VBoxClient --seamless
# terminal service
urxvtd -q -o -f
/usr/local/bin/VBoxClient --clipboard
# window manager
/usr/local/bin/VBoxClient --checkhostversion
# root background image
if [ -f "${HOME}/.fehbg" ]; then
  ~/.fehbg
else
  feh --bg-fill "${HOME}/Pictures/bg.png"
fi
exec i3

