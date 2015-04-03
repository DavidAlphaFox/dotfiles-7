#!/bin/sh

if [ -f "$HOME/.xinit_localrc" ]; then
    . "$HOME/.xinit_localrc"
fi

startxfce4
rm ~/.serverauth.*
