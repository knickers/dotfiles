alias ll='ls -l'
alias la='ls -Al'
alias sl='ls -lh'
alias sla='ls -Alh'
alias l1='ls -1'
alias ..='cd ..'
alias .1='cd ..'
alias .2='cd ../..'
alias .3='cd ../../..'
alias .4='cd ../../../..'
alias .5='cd ../../../../..'
alias wget='wget -c'
alias serve='python -m SimpleHTTPServer'

# safety nets
alias rm='rm -I --preserve-root'
alias mv='mv -i'
alias cp='cp -i'
alias ln='ln -i'
alias chown='chown --preserve-root'
alias chmod='chmod --preserve-root'
alias chgrp='chgrp --preserve-root'

# 4 space tabs!
alias less='less -x4'
GIT_PAGER='less -x4'
tabs 4
