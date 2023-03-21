#  .zshrc
#

#locale
export LANG=ja_JP.UTF-8
#locale
export GOPATH=~/go
export PATH=~/bin:$GOPATH/bin:/usr/local/bin:"$PATH"
typeset -U path PATH

## always give group write permission for create file and dir
#umask 002

alias ls='LC_COLLATE=C ls -laF'

export emacs=/Applications/Emacs.app/Contents/MacOS/Emacs
alias emacs='$emacs &!'   #disown

alias emx='TERM=xterm $emacs -nw'
alias emt='TERM=vt100 VT100=yes $emacs -nw'
#alias emv='TERM=vt100 $emacs -nw'

alias em='$emacs -nw'

alias emd='$emacs -nw --debug-init'

alias python=python3
alias pip=pip3

alias tar=/usr/local/bin/gtar

. ~/.dirrc

alias ]='cd ..'
alias ]]='cd ../..'
alias ]]]='cd ../../..'
alias ]]]]='cd ../../../..'
alias ]]]]]='cd ../../../../..'
       
if [ "$TERM" = dumb ]; then
    #export PS1="%n@%m %1~ %# "
    export PS1="%n@%m %~ %# "
else
    export PS1="|
%n@%m %1~ %# "
fi    

## # docker build output->not colord
## export BUILDKIT_PROGRESS=plain
#
## use
#  docker-compose --ansi=never up -d
#
