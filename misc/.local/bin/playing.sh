#!/bin/bash

artist="$(playerctl metadata xesam:artist)"
if [ -n "$artist" ]; then
  echo "🎶 $artist \"$(playerctl metadata xesam:title)\""
fi
