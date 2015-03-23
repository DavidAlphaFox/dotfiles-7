#!/bin/bash

CACHE=/var/cache/cygsetup

if [ ! -f "$CACHE/.required" ]; then
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
    echo
    echo "installing required packages, run again when complete"
    cygstart -- $CACHE/$CYGEXE -g -n -K $PORTS_GPG -s $PORTS_MIRROR -s $MIRROR -q -l "$CACHE_WIN" -P $BASE_PKGS
    echo $BASE_PKGS > $CACHE/.required
    exit 1
else
    cd $HOME
    git clone -b cygwin https://github.com/starlight/dotfiles.git .dotfiles

    WINHOME="`cygpath $USERPROFILE`"
    dir=.dotfiles                    # dotfiles directory
    olddir=.backup_dotfiles          # old dotfiles backup directory
    
    echo "backing-up existing dotfiles, setting up symlinks"
    mkdir -p $olddir
    # symlink dotfiles, making backup of existing
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

    echo "installing 'Shell...' context menu"
    # install shell context-menu
    chere -u
    chere -icm -t mintty -s bash -e 'Shell...'

    echo "placing XWin shortcut into Startup"
    # install XWin to Windows Startup
    cp $dir/extra/cygwinx.lnk `cygpath $APPDATA`/Microsoft/Windows/Start\ Menu/Programs/Startup/

    echo "Setting focus-follows-mouse, no auto-raise in Windows"
    .bin/sudo reg import ~/.extra/xmouse.reg
    rm $CACHE/http* -r
fi

