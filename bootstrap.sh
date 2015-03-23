#!/bin/bash

CACHE=/var/cache/cygsetup

if [ ! -f "$CACHE/.required" ]; then
    echo "installing required packages, run again when complete"
    CACHE_WIN="`cygpath -w $CACHE`"
    CYGEXE=setup-x86_64.exe
    EXEURL=http://cygwin.com/$CYGEXE
    MIRROR=http://mirrors.kernel.org/sourceware/cygwin
    PORTS_MIRROR=http://mirrors.kernel.org/sources.redhat.com/cygwinports
    PORTS_GPG=http://cygwinports.org/ports.gpg
    BASE_PKGS=alacarte,chere,ctags,git,git-completion,gtk2.0-engines-murrine,libnotify,psmisc,screen,vim,xfce4-notifyd,xfce4-session

    mkdir -p $CACHE
    cd $CACHE
    wget -nv -N $EXEURL
    chmod +x ./$CYGEXE

    cygstart -- $CACHE/$CYGEXE -g -n -K $PORTS_GPG -s $PORTS_MIRROR -s $MIRROR -q -l "$CACHE_WIN" -P $BASE_PKGS
    echo $BASE_PKGS > $CACHE/.required
    exit 1
else
    cd $HOME
    git clone https://github.com/starlight/dotfiles.git .dotfiles
    bash .dotfiles/install.sh
fi



