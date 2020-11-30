# ~/.bashrc: executed by bash(1) for non-login shells.
# see /usr/share/doc/bash/examples/startup-files (in the package bash-doc)
# for examples

# If not running interactively, don't do anything
case $- in
	*i*) ;;
	  *) return;;
esac

export PATH="/sbin:/usr/sbin:/usr/local/sbin:$PATH:$HOME/sbin:$HOME/bin"

HISTSIZE=1000                       # history length
HISTFILESIZE=2000
export HISTTIMEFORMAT='%Y-%m-%d %H:%M:%S  '# store pretty history timestamps
export HISTCONTROL=erasedups               # get rid of all duplicates
shopt -s histappend                 # append to the history file, don't overwrite it
shopt -s checkwinsize               # update window LINES and COLUMNS after each command

export GIT_PS1_SHOWDIRTYSTATE=1
export GIT_PS1_SHOWSTASHSTATE=1
export GIT_PS1_SHOWUNTRACKEDFILES=1
export GIT_PAGER='less -x4' # 4 space tabs!

export      EDITOR='vim'
export  GIT_EDITOR="$EDITOR"
export SUDO_EDITOR="$EDITOR"

export TERM='xterm-256color'
export GOPATH="$HOME/go"

tabs 4 # 4 space tabs!

##### Make my custom prompt colors #####
RED='\[\033[0;31m\]'
WHITE='\[\033[1;37m\]'
GREEN='\[\033[0;32m\]'
LIGHTGREEN='\[\033[1;32m\]'
LIGHTBLUE='\[\033[1;34m\]'
RESET='\[\033[0m\]'

# git propt
GITDIR="\$(git-prompt.sh)"

PS1="$LIGHTGREEN\u $GREEN\h $LIGHTBLUE\w$WHITE$GITDIR$RED \\\$$RESET"

if command -v figlet &> /dev/null; then
	figlet -tc "$USER  @  $HOSTNAME"
fi

if [ "$USER" == "root" ]; then
	echo ''
	if command -v figlet &> /dev/null; then
		figlet -tcf small 'yippee ki yay!'
	fi
fi

# enable color support of ls and also add handy aliases
if [ -x /usr/bin/dircolors ]; then
	test -r ~/.dircolors && eval "$(dircolors -b ~/.dircolors)" || eval "$(dircolors -b)"
	alias ls='ls --color=auto'
	alias grep='grep --color=auto'
fi

alias less='less -x4' # 4 space tabs!
alias ll='ls -l'
alias la='ls -Al'
alias sl='ls -lh'
alias sla='ls -Alh'
alias l1='ls -1'
#alias ..='cd ..'
alias wget='wget -c'

# safety nets
alias rm='rm -I --preserve-root'
alias mv='mv -i'
alias cp='cp -i'
alias ln='ln -i'
alias chown='chown --preserve-root'
alias chmod='chmod --preserve-root'
alias chgrp='chgrp --preserve-root'

# Alias definitions.
# You may want to put all your additions into a separate file like
# ~/.bash_aliases, instead of adding them here directly.

alias serve='python -m SimpleHTTPServer'
#alias yt='docker run --rm -u $(id -u):$(id -g) -v "$PWD":/data vimagick/youtube-dl'
#alias ffmpeg='docker run --rm -u $(id -u):$(id -g) -v "$PWD:$PWD" -w "$PWD" nachochip/ffmpeg "$@"'
