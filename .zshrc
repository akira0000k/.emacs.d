#  .zshrc
#

#locale
export LANG=ja_JP.UTF-8
export LC_COLLATE=C
#locale
export GOPATH=~/go
export PATH=~/bin:$GOPATH/bin:/usr/local/bin:"$PATH"
typeset -U path PATH

## always give group write permission for create file and dir
#umask 002

alias ls='ls -laF'

export emacs=/Applications/Emacs.app/Contents/MacOS/Emacs
alias emax='$emacs &!'   #disown

alias emx='TERM=xterm $emacs -nw'
alias ems='SCREEN=yes $emacs -nw'
alias emt='TERM=vt100 VT100=yes $emacs -nw'
alias emv='TERM_PROGRAM=vscode $emacs -nw'
alias empu='PUTTY=yes $emacs -nw'

alias em='$emacs -nw'

alias emd='$emacs -nw --debug-init'

alias profd="printf '\033]1337;SetProfile=Default\a'"
alias proft="printf '\033]1337;SetProfile=Default Transparent\a'"
alias profm="printf '\033]1337;SetProfile=tmux\a'"
alias scren="proft; screen"

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

##export DICTIONARY=en_US
####export DICPATH=~/Library/Spelling
