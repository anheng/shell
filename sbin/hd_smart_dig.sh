#!/bin/sh

for dev in /dev/[hs]d[a-z]
do
smartctl -s on -d ata -t long $dev  >/dev/null
done
