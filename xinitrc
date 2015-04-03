#!/bin/sh

if [ -f "$HOME/.xinit_localrc" ]; then
    . ~/.xinit_localrc
fi

startxfce4
rm ~/.serverauth.*

