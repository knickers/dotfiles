# ~/.bashrc: executed by bash(1) for non-login shells.
# see /usr/share/doc/bash/examples/startup-files (in the package bash-doc)
# for examples

# If not running interactively, don't do anything
case $- in
	*i*) ;;
	  *) return;;
esac

# set PATH so it includes user's private bins if they exist
if [ -d "$HOME/bin" ]; then
	PATH="$HOME/bin:$PATH"
fi
if [ -d "$HOME/.local/bin" ]; then
	PATH="$HOME/.local/bin:$PATH"
fi

HISTSIZE=1000          # history length see HISTSIZE and HISTFILESIZE in bash(1)
HISTFILESIZE=2000      # max lines in history file
HISTCONTROL=ignoreboth # don't add duplicate lines or lines starting with space
shopt -s histappend    # append to the history file, don't overwrite it
shopt -s checkwinsize  # update window LINES and COLUMNS after each command
#shopt -s globstar     # "**" in pathname matches all files & zero or more dirs

     EDITOR='vim'
 GIT_EDITOR="$EDITOR"
SUDO_EDITOR="$EDITOR"

# make less more friendly for non-text input files, see lesspipe(1)
#[ -x /usr/bin/lesspipe ] && eval "$(SHELL=/bin/sh lesspipe)"

# set variable identifying the chroot you work in (used in the prompt below)
if [ -z "${debian_chroot:-}" ] && [ -r /etc/debian_chroot ]; then
	debian_chroot=$(cat /etc/debian_chroot)
fi

# set a fancy prompt if color is supported
case "$TERM" in
	xterm-color|*-256color) color_prompt=yes;;
esac

if [ -x /usr/bin/tput ] && tput setaf 1 >&/dev/null; then
	# We have color support; assume it's compliant with Ecma-48
	# (ISO/IEC-6429). (Lack of such support is extremely rare, and such
	# a case would tend to support setf rather than setaf.)
	color_prompt=yes
else
	color_prompt=
fi

# run colors.sh for color table
WHITE='\[\033[1;37m\]'
green='\[\033[0;32m\]'
GREEN='\[\033[1;32m\]'
 BLUE='\[\033[1;34m\]'
reset='\[\033[0;00m\]'

PS1='${debian_chroot:+($debian_chroot)}'

if command -v git-prompt.sh &> /dev/null; then
	GIT_PS1_SHOWDIRTYSTATE=1
	GIT_PS1_SHOWSTASHSTATE=1
	GIT_PS1_SHOWUNTRACKEDFILES=1
	GIT='$(git-prompt.sh)'
fi

if [ "$color_prompt" = yes ]; then
	PS1=$PS1"$GREEN\u $green\h $BLUE\w$WHITE$GIT $GREEN\\\$$reset"
else
	PS1=$PS1"\u \h \w $GIT \$"
fi
unset color_prompt WHITE green GREEN BLUE reset GIT

# If this is an xterm set the title to user@host:dir
case "$TERM" in
	xterm*|rxvt*)
		PS1="\[\e]0;${debian_chroot:+($debian_chroot)}\u \h \w\a\]$PS1"
		;;
	*)
		;;
esac

# enable color support of ls and also add handy aliases
if [ -x /usr/bin/dircolors ]; then
	test -r ~/.dircolors && \
		eval "$(dircolors -b ~/.dircolors)" || \
		eval "$(dircolors -b)"
	alias ls='ls --color=auto'
	alias grep='grep --color=auto'
	alias fgrep='fgrep --color=auto'
	alias egrep='egrep --color=auto'
fi

# colored GCC warnings and errors
#export GCC_COLORS='error=01;31:warning=01;35:note=01;36:caret=01;32:locus=01:quote=01'

# Alias definitions.
# See /usr/share/doc/bash-doc/examples in the bash-doc package.
if [ -f ~/.bash_aliases ]; then
	. ~/.bash_aliases
fi

# enable programmable completion features (you don't need to enable
# this, if it's already enabled in /etc/bash.bashrc and /etc/profile
# sources /etc/bash.bashrc).
if ! shopt -oq posix; then
	if [ -f /usr/share/bash-completion/bash_completion ]; then
		. /usr/share/bash-completion/bash_completion
	elif [ -f /etc/bash_completion ]; then
		. /etc/bash_completion
	fi
fi

if [ -f ~/.bash_prompt ]; then
	. ~/.bash_prompt
fi
