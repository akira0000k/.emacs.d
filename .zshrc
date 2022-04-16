#  .zshenv
#

#locale
export LANG=ja_JP.UTF-8
#locale
export GOPATH=~/go
export PATH=~/bin:$GOPATH/bin:/usr/local/bin:"$PATH"
typeset -U path PATH

## always give group write permission for create file and dir
#umask 002

alias ls='ls -laF'

export emacs=/Applications/Emacs.app/Contents/MacOS/Emacs
alias emacs='$emacs &!'   #disown
alias emac='TERM=xterm $emacs &!'   #disown
alias ema='TERM=xterm-256color $emacs -nw'
alias em='TERM=xterm $emacs -nw'
alias emd='TERM=xterm $emacs -nw --debug-init'
alias python=python3
alias tar=/usr/local/bin/gtar

alias filemerge=opendiff
alias coded='code -d'

#export A_DIRECTORY=~/go/src/sample/Twitter-anaconda
export A_DIRECTORY=~/go/src/sample/13gRPC
export B_DIRECTORY=~/.emacs.d
export C_DIRECTORY=~/DOCKER/COMPOSE/compose/context03
export E_DIRECTORY=~/Desktop
#export A_DIRECTORY=
#export B_DIRECTORY=
#export C_DIRECTORY=
#export E_DIRECTORY=

cda() { cd $A_DIRECTORY; }
#cdb() { cd $B_DIRECTORY; }
#cdc() { cd $C_DIRECTORY; }
#cde() { cd $E_DIRECTORY; }
#cda() { cd "$A_DIRECTORY"; }
cdb() { cd "$B_DIRECTORY"; }
#cdc() { cd "$C_DIRECTORY"; }
#cde() { cd "$E_DIRECTORY"; }
#alias cda='cd $A_DIRECTORY' 
#alias cdb='cd $B_DIRECTORY' 
alias cdc='cd $C_DIRECTORY' 
#alias cde='cd $E_DIRECTORY' 
#alias cda="cd '$A_DIRECTORY'"
#alias cdb="cd '$B_DIRECTORY'"
#alias cdc="cd '$C_DIRECTORY'"
alias cde="cd '$E_DIRECTORY'"

debian2=akira@192.168.200.128
debian=akira@192.168.200.129
alias debian2='ssh $debian2'
alias debian='ssh $debian'

alias ]='cd ..'
alias ]]='cd ../..'
alias ]]]='cd ../../..'
alias ]]]]='cd ../../../..'
alias ]]]]]='cd ../../../../..'
       
if [ "$TERM" = dumb ]; then
    export PS1="%n@%m %1~ %# "
else
    export PS1="|
%n@%m %1~ %# "
fi    

# docker build output->not colord
export BUILDKIT_PROGRESS=plain

