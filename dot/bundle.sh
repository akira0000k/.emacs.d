#!/bin/bash
{
    cat 0[0-9]*.el

    grep -v '^(load\|^;;;;' .emacs.el
} > ../.emacs.el
