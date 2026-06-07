#  .zshrc
#
#echo ".zshrc arg=" "${(%):-%N}"
currentdir=$(dirname "${(%):-%N}")

#locale
export LANG=ja_JP.UTF-8
export LC_COLLATE=C

export GOPATH=~/go
export PATH=~/bin:$GOPATH/bin:/usr/local/bin:"$PATH"
typeset -U path PATH

## always give group write permission for create file and dir
#umask 002

alias ls='ls -laF'

## emacs version choice
#echo source "$currentdir/.emchoice"
source "$currentdir/.emchoice"

alias profd="printf '\033]1337;SetProfile=Default\a'"
alias proft="printf '\033]1337;SetProfile=Default Transparent\a'"
alias profm="printf '\033]1337;SetProfile=tmux\a'"
alias scren="proft; screen"

alias python=python3
alias pip=pip3

alias tar=/usr/local/bin/gtar

## My favorite directories A, B, C, E(, Z)
#echo source "$currentdir/.dirrc"
source "$currentdir/.dirrc"

alias "]"='cd ..'
alias "]]"='cd ../..'
alias "]]]"='cd ../../..'
alias "]]]]"='cd ../../../..'
alias "]]]]]"='cd ../../../../..'
alias "]]]]]]"='cd ../../../../../..'

export PS1="|
%n@%m %1~ %# "

## # docker build output->not colord
## export BUILDKIT_PROGRESS=plain
#
## use
#  docker-compose --ansi=never up -d
#

export DICTIONARY=en_US
export DICPATH=~/.emacs.d/Spelling
