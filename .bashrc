# login shell setting

PS1='$0@\u:\w\$ '

export LANG=ja_JP.UTF-8

alias ll='/bin/ls -laF'
alias ls=ll
alias em='TERM=xterm emacs -nw'
alias emt='TERM=vt100 VT100=yes emacs -nw'
alias emp='TERM=xterm-256color PUTTY=yes emacs -nw'
alias emq='TERM=xterm PUTTY=yes emacs -nw'

alias ]='cd ..'
alias ]]='cd ../..'
alias ]]]='cd ../../..'
alias ]]]]='cd ../../../..'
alias ]]]]]='cd ../../../../..'
alias ]]]]]]='cd ../../../../../..'

export A_DIRECTORY=/var
export B_DIRECTORY=~/.emacs.d
export C_DIRECTORY=/usr
export E_DIRECTORY=/etc

alias cda="cd '$A_DIRECTORY'"
alias cdb="cd '$B_DIRECTORY'"
alias cdc="cd '$C_DIRECTORY'"
alias cde="cd '$E_DIRECTORY'"
