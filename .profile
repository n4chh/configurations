# ~/.profile: executed by the command interpreter for login shells.
# This file is not read by bash(1), if ~/.bash_profile or ~/.bash_login
# exists.
# see /usr/share/doc/bash/examples/startup-files for examples.
# the files are located in the bash-doc package.

# the default umask is set in /etc/profile; for setting the umask
# for ssh logins, install and configure the libpam-umask package.
#umask 022

# if running bash
if [ -n "$BASH_VERSION" ]; then
    # include .bashrc if it exists
    if [ -f "$HOME/.bashrc" ]; then
	. "$HOME/.bashrc"
    fi
fi

# Fix the Java Problem
export _JAVA_AWT_WM_NONREPARENTING=1


[ -f '/home/kali/.local/target.txt' ] &&  export TARGET="$(cat /home/kali/.local/target.txt)"
[ -f '/home/kali/.local/targetdir.txt' ] &&  export TARGETDIR="$(cat /home/kali/.local/targetdir.txt)"
[ -f '/home/kali/.local/workspace.txt' ] && export WS="$(cat /home/kali/.local/workspace.txt)"
# export JAVA_HOME="$(/usr/libexec/java_home)"

export EDITOR=vim
export VISUAL=vim
#
# INCLUSION BINARIOS
#
# Export PATH$
#export PATH=/snap/bin:/usr/sandbox/:/usr/local/bin:/usr/bin:/bin:/usr/local/games:/usr/games:/usr/share/games:/usr/local/sbin:/usr/sbin:/sbin:/opt/bin:/opt/nvim-linux64/bin:$PATH
#Binarios go
export PATH=$PATH:$HOME/go/bin
# BINARIOS PROPIOS
export PATH="$HOME/.config/bin:$PATH"
# BINARIOS YARN
export PATH="$HOME/.yarn/bin:$PATH"
# BINARIOS CARGO
export PATH="$PATH:$HOME/.cargo/bin"
# BINARIOS PYTHON
export PATH="$PATH:$HOME/.local/bin"
# BINARIOS RVM
export PATH="$PATH:$HOME/.rvm/bin"


