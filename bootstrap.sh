#!/bin/bash

CYGEXE=setup-`uname -m`.exe
EXEURL=http://cygwin.com/$CYGEXE
MIRROR=http://mirrors.kernel.org/sourceware/cygwin
PORTS_MIRROR=http://mirrors.kernel.org/sources.redhat.com/cygwinports
PORTS_GPG=http://cygwinports.org/ports.gpg
DOTFILES_GIT=https://github.com/starlight/dotfiles.git
BASE_PKGS="ctags,git-completion,psmisc,screen,tree,vim,gvim,xfce4-session,gtk2.0-engines-murrine,cygutils-extra,cygutils-x11,alacarte,file-roller,dos2unix,seahorse,seahorse-tool"

if [ ! -f "/.required" ]; then
    cd /bin
    wget -q -nv -N $EXEURL
    chmod +x ./$CYGEXE
    echo
    echo -e "\033[31mInstalling required packages, run again when complete"
    cygstart -- $CYGEXE -o -g -n -K $PORTS_GPG -s $MIRROR -s $PORTS_MIRROR -q -P $BASE_PKGS
    touch /.required
    exit 0
else
    if [ -f "/.installed" ]; then
        echo -e "\033[31mAlready installed"
        exit 1
    fi
    cd $HOME
    git clone -b cygwin $DOTFILES_GIT .dotfiles
    cd .dotfiles; git checkout -f HEAD
    cd ..

    WINHOME="`cygpath $USERPROFILE`"
    dir=.dotfiles                    # dotfiles directory
    olddir=.backup_dotfiles          # old dotfiles backup directory
    
    echo "Backing-up existing dotfiles, setting up symlinks"
    mkdir -p $olddir
    for file in `ls $dir | grep -v -e 'README.md' -e 'bootstrap'`; do
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

    echo "Placing XWin shortcut into Startup"
    mkshortcut -w "$HOME" -s min -n cygwinx -d startxwin-rootless -a '-w hide /bin/sh.exe ~/.bin/startxwin-rootless' /bin/mintty.exe

    mv cygwinx.lnk `cygpath $APPDATA`/Microsoft/Windows/Start\ Menu/Programs/Startup/

    touch /.installed

    echo
    echo -e "\033[32mReboot/login to start XFCE!"
fi
