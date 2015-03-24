## [starlight](http://starlight.github.io/)/dotfiles

These are my dotfiles, for bash, vim, xfce4, screen, ssh-agent and more.

    cd ~
    git clone https://github.com/starlight/dotfiles.git .dotfiles
    .dotfiles/bin/dotfiles-install

pre-existing dotfiles will be saved to ~/.old_dotfiles

### depends on screen, ssh
### optional: pylint, pyflakes, jshint, xfce4, xfce4-terminal, ctags and w3m


working on unattended install for full cygwin environment:

    wget -O - https://raw.githubusercontent.com/starlight/dotfiles/cygwin/bootstrap.sh | tee bootstrap.sh | bash
    (wait for completion of package install)
    bash bootstrap.sh
    
