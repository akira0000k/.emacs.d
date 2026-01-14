#!/bin/bash

cat user-src.txt |
    awk -Ft '
BEGIN{
    USRNO=0
}
{
    if (/^User/) {
        printf(";                         %s\nUser%d%s\n", $2, ++USRNO, substr($1, 5));
        if (USRNO==99) { exit 0 }
    } else if (! /^#/) { print $0 }
}
' > KOSMAX-UserKeys.txt
