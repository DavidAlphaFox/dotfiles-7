#!/bin/bash

artist="$(playerctl metadata xesam:artist)"
if [ -n "$artist" ]; then
  echo "🎶 $(playerctl metadata xesam:title) ($artist)"
fi
