#!/bin/bash

if [ "a$1" == "a" ] ; then
echo please run :$0 sda
exit
fi
badblocks -b 512 -o /$1.bad /dev/$1
