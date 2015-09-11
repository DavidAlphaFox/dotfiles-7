#!/bin/bash

CYGEXE=setup-`uname -m`.exe
EXEURL=http://cygwin.com/$CYGEXE
MIRROR=http://mirrors.kernel.org/sourceware/cygwin
PORTS_MIRROR=http://mirrors.kernel.org/sources.redhat.com/cygwinports
PORTS_GPG=http://cygwinports.org/ports.gpg
DOTFILES_GIT=https://github.com/starlight/dotfiles.git
BASE_PKGS="alacarte,ctags,cygcheck-dep,cygutils-extra,dos2unix,git-completion,gtk2.0-engines-murrine,gvim,libcryptui-common,libnotify,procps,psmisc,screen,seahorse,seahorse-daemon,seahorse-tool,thunar-archive-plugin,tree,vim,xfce4-notifyd,xfce4-session"

cd /usr/local/bin
lynx -source rawgit.com/transcode-open/apt-cyg/master/apt-cyg > apt-cyg
chmod +x apt-cyg
bash -c "echo http://mirrors.kernel.org/sourceware/cygwin | apt-cyg mirror"
bash -c "echo wget | apt-cyg install"
bash -c "echo git | apt-cyg install"
rm apt-cyg

echo "Cloning starlight/dotfiles repo..."
cd $HOME
umask 022
git clone -b cygwin $DOTFILES_GIT .dotfiles
cd .dotfiles; git checkout -f HEAD
cd ..

WINHOME="`cygpath $USERPROFILE`"
dir=.dotfiles                    # dotfiles directory
olddir=.dotfiles.bak          # old dotfiles backup directory

echo "Saving existing dotfiles to $olddir, setting up symlinks"
mkdir -p $olddir
for file in `ls $dir | grep -v -e 'README.md' -e 'bootstrap'`; do
    cp -rL .$file $olddir/ 2>/dev/null
    rm -rf .$file
    ln -s $dir/$file .$file
done
mv .profile $olddir/
ln -s $WINHOME .user

# symlinks into windows User directory
for i in Desktop Public Documents Downloads Pictures Music Templates Videos; do 
    mkdir -p .user/$i
    ln -s .user/$i $i
done

echo "Placing Deneb shortcut into Start Menu"
mkshortcut -P -w "$HOME" -i/bin/run.exe -j2 -s min -n Deneb -d startx-rootless -a '-w hide -e /bin/bash.exe -l -c startx-rootless' /bin/mintty.exe

cd /bin
wget -q -nv -N $EXEURL
chmod +x ./$CYGEXE
echo
echo -e "\033[31mInstalling remaining packages"
cygstart -- $CYGEXE -o -g -n -K $PORTS_GPG -s $MIRROR -s $PORTS_MIRROR -q -P $BASE_PKGS -B

