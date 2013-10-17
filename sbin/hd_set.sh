#!/bin/sh
for dev in "/dev/[hs]d[a-z]"
do
hdparm -B 254 $dev >/dev/null 2>/dev/null
hdparm -S 251 $dev >/dev/null 2>/dev/null
done
