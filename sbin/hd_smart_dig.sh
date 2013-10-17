#!/bin/sh

#/etc/crontab
#30 0 12,28 * * root hd_smart_dig.sh
#30 6 * * 1 root hd_smart_report.sh

for dev in /dev/[hs]d[a-z]
do
smartctl -s on -d ata -t long $dev  >/dev/null
done
