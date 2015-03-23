#!/bin/bash

dir=.dotfiles                    # dotfiles directory
olddir=.old_dotfiles             # old dotfiles backup directory

mkdir -p ~/$olddir

# change to the dotfiles directory
cd ~

# symlink dotfiles, making backup of existing
for file in `ls ~/$dir | grep -v -e 'README.md' -e 'install.sh' -e 'bootstrap.sh'`; do
    echo ~/$file
    cp -rL ~/.$file ~/$olddir/
    rm -r ~/.$file
    ln -s $dir/$file .$file
done
mv .profile ~/$olddir/

# home directory symlinks
ln -s `cygpath $USERPROFILE` .user
ln -s $HOME /.admin

# symlinks into windows User directory
for i in Desktop Public Documents Downloads Pictures Music Videos Diagrams Templates; do 
    mkdir -p .user/$i
    ln -s .user/$i $i
done

# install shell context-menu
chere -u
chere -icm -t mintty -s bash -e 'Shell...'

# install XWin to Windows Startup
cp $dir/extra/cygwinx.lnk `cygpath $APPDATA`/Microsoft/Windows/Start\ Menu/Programs/Startup/

.bin/sudo reg import ~/.extra/xmouse.reg

