#!/bin/bash

CACHE=/var/cache/cygsetup
CYGEXE=setup-`uname -m`.exe
EXEURL=http://cygwin.com/$CYGEXE
MIRROR=http://mirrors.kernel.org/sourceware/cygwin
PORTS_MIRROR=http://mirrors.kernel.org/sources.redhat.com/cygwinports
PORTS_GPG=http://cygwinports.org/ports.gpg
BASE_PKGS="chere,git,gtk2.0-engines-murrine,psmisc,screen,tree,vim,xfce4-session"

if [ ! -f "$CACHE/.required" ]; then
    mkdir -p $CACHE
    cd $CACHE
    wget -q -nv -N $EXEURL
    chmod +x ./$CYGEXE
    echo
    echo -e "\033[31mInstalling required packages, run again when complete"
    cygstart -- $CACHE/$CYGEXE -o -g -n -K $PORTS_GPG -s $MIRROR -s $PORTS_MIRROR -q -P $BASE_PKGS
    touch $CACHE/.required
    exit 0
else
    if [ -f "$CACHE/.installed" ]; then
        echo -e "\033[31mAlready installed"
        exit 1
    fi
    cd $HOME
    git clone -b cygwin https://github.com/starlight/dotfiles.git .dotfiles
    cd .dotfiles; git checkout -f HEAD
    cd ..

    WINHOME="`cygpath $USERPROFILE`"
    dir=.dotfiles                    # dotfiles directory
    olddir=.backup_dotfiles          # old dotfiles backup directory
    
    echo "Backing-up existing dotfiles, setting up symlinks"
    mkdir -p $olddir
    for file in `ls $dir | grep -v -e 'README.md' -e 'bootstrap.sh'`; do
        cp -rL .$file $olddir/ 2>/dev/null
        rm -rf .$file
        ln -s $dir/$file .$file
    done
    mv .profile $olddir/

    # home directory symlinks
    ln -s $WINHOME .user
    ln -s $HOME /.root

    # symlinks into windows User directory
    for i in Desktop Public Documents Downloads Pictures Music Videos Diagrams Templates; do 
        mkdir -p .user/$i
        ln -s .user/$i $i
    done

    echo "Installing 'Shell...' context menu"
    chere -u
    chere -icm -t mintty -s bash -e 'Shell...'

    echo "Setting focus-follows-mouse, no auto-raise in Windows"
    .bin/sudo reg import ~/.extra/xmouse.reg
    rm $CACHE/http* -r
    touch $CACHE/.installed

    echo "Placing XWin shortcut into Startup"
    cp $dir/extra/cygwinx.lnk `cygpath $APPDATA`/Microsoft/Windows/Start\ Menu/Programs/Startup/

    echo
    echo -e "\033[32mReboot/login to start XFCE!"
fi
