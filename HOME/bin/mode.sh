#!/bin/bash
#set -x

file=${1?"no parameter"}

sed -i "~" '1s/-\*- m o d e:/-*- mode:/' $file
