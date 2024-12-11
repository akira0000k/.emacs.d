#!/bin/sh

awk '
/^;;;;/ {
    next
}

/^\(load ".*"\)/ {
    match($0, /".*"/);
    file=substr($0, RSTART+1, RLENGTH-2)
    comd = "cat " file
    system(comd)
    next
}

{
    print
}' .emacs.el > ../.emacs.el
