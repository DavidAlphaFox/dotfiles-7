#!/bin/sh

/usr/local/bin/VBoxClient --display
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
/usr/local/bin/VBoxClient --seamless
# terminal service
urxvtd -q -o -f
/usr/local/bin/VBoxClient --clipboard
# window manager
/usr/local/bin/VBoxClient --checkhostversion
exec i3

