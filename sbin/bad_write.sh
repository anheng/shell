#!/bin/bash

if [ "a$2" == "a-yes" ]
then

if ! [ -s $1.bad ]
then
exit
fi

while read t
do
if  [ -s /tmp/$1.bad_$t ]
then
echo dd of=/dev/$1 bs=4096 seek=$t if=/tmp/$1.bad_$t count=1
dd of=/dev/$1 bs=4096 seek=$t if=/tmp/$1.bad_$t count=1
dd of=/dev/$1 bs=4096 seek=$t if=/tmp/$1.bad_$t count=1
else 
echo dd of=/dev/$1 bs=4096 seek=$t if=/dev/zero count=1
dd of=/dev/$1 bs=4096 seek=$t if=/dev/zero count=1
dd of=/dev/$1 bs=4096 seek=$t if=/dev/zero count=1
fi
done <$1.bad
fi
