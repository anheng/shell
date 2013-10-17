#!/bin/bash

if ! [ -s $1.bad ] ; then
exit
fi

while read t
do
if ! [ -s /tmp/$1.bad_$t ] ; then
dd if=/dev/$1 bs=4096 skip=$t of=/tmp/$1.bad_$t count=1
fi
done <$1.bad
