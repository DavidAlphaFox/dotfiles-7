#!/bin/bash

CYGEXE=setup-`uname -m`.exe
EXEURL=http://cygwin.com/$CYGEXE
MIRROR=http://mirrors.kernel.org/sourceware/cygwin
PORTS_MIRROR=http://mirrors.kernel.org/sources.redhat.com/cygwinports
PORTS_GPG=http://cygwinports.org/ports.gpg
DOTFILES_GIT=https://github.com/starlight/dotfiles.git
BASE_PKGS="alacarte,ctags,cygutils-x11,dos2unix,file-roller,git-completion,gtk2.0-engines-murrine,gvim,libcryptui-common,libnotify,psmisc,screen,seahorse,seahorse-daemon,seahorse-tool,tree,vim,xfce4-notifyd,xfce4-session"

cd /bin

lynx -source rawgit.com/transcode-open/apt-cyg/master/apt-cyg > apt-cyg
chmod +x apt-cyg
bash -c "echo http://mirrors.kernel.org/sourceware/cygwin | apt-cyg mirror"
bash -c "echo wget | apt-cyg install"
bash -c "echo git | apt-cyg install"
bash -c "echo cygcheck-dep | apt-cyg install"
bash -c "echo cygutils-extra | apt-cyg install"
rm apt-cyg

cd $HOME
umask 022
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
for i in Desktop Public Documents Downloads Pictures Music Videos; do 
    mkdir -p .user/$i
    ln -s .user/$i $i
done

echo "Placing XWin shortcut into Startup"
mkshortcut -w "$HOME" -i/bin/run.exe -j2 -s min -n cygwin-xfce -d startxwin-rootless -a '-w hide /bin/sh.exe ~/.bin/startxwin-rootless' /bin/mintty.exe

mv cygwin-xfce.lnk `cygpath $APPDATA`/Microsoft/Windows/Start\ Menu/Programs/Startup/

wget -q -nv -N $EXEURL
chmod +x ./$CYGEXE
echo
echo -e "\033[31mInstalling required packages, run again when complete"
cygstart -- $CYGEXE -o -g -n -K $PORTS_GPG -s $MIRROR -s $PORTS_MIRROR -q -P $BASE_PKGS

~/.bin/cygleaf > /etc/setup/.cygwin-xfce

echo
echo -e "\033[32Re-login to start cygwin-xfce"

