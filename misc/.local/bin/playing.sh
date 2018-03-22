#!/bin/bash

artist="$(playerctl metadata xesam:artist)"
if [ -n "$artist" ]; then
  echo "  $artist \"$(playerctl metadata xesam:title)\""
fi

case $BLOCK_BUTTON in
  1) playerctl play-pause ;;
  3) playerctl next ;;
esac
