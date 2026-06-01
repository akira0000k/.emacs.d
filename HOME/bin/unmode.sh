#!/bin/bash
#set -x

file=${1?"no parameter"}

sed -i "~" '1s/-\*- mode:/-*- m o d e:/' $file
