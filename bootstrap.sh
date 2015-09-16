#!/bin/bash

CYGEXE=setup-`uname -m`.exe
EXEURL=http://cygwin.com/$CYGEXE
MIRROR=http://mirrors.kernel.org/sourceware/cygwin
PORTS_MIRROR=http://mirrors.kernel.org/sources.redhat.com/cygwinports
DENEB_MIRROR=http://sirius.starlig.ht/
PORTS_GPG=http://cygwinports.org/ports.gpg
DENEB_GPG=http://sirius.starlig.ht/sirius.gpg
DOTFILES_GIT=https://github.com/starlight/dotfiles.git
BASE_PKGS="alacarte,ctags,gvim,screen,tree,vim"

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

CYGWIN="winsymlinks"
echo "Saving existing dotfiles to $olddir, setting up symlinks"
mkdir -p $olddir
for file in `ls $dir | grep -v -e 'README.md' -e 'bootstrap'`; do
    cp -rL .$file $olddir/ 2>/dev/null
    rm -rf .$file
    ln -s $dir/$file .$file
done
mv .profile $olddir/
ln -s $WINHOME .user

echo -e "\033[31mInstalling remaining packages"
cd /bin
wget -q -nv -N $EXEURL
chmod +x ./$CYGEXE
cygstart -- $CYGEXE -o -g -n -K $PORTS_GPG -K $DENEB_GPG -s $MIRROR -s $PORTS_MIRROR -s $DENEB_MIRROR -q -P $BASE_PKGS -B

