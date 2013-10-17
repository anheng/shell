#!/bin/bash
email=`cat /etc/default/admin_email`
if [ "a$email" == "a" ] ; then
 echo null
 email=liushiwei@gmail.com
fi
#liushiwei@gmail.com -c lisongsen@anheng.com.cn
export LANG=zh_CN.utf8
for dev in  `ls /dev/disk/by-id/ata* |grep -v part` 
do
 rm -f /tmp/mail.txt
 devname=$( basename $dev )
 touch /var/log/${devname}.old.txt
 if [ -s /var/log/${devname}.txt ] ; then
  mv /var/log/${devname}.txt /var/log/${devname}.old.txt
 fi
 smartctl -s on -d ata -a $dev >/tmp/test.txt

 #到"# 2 Extended offline"这一行截断。
 while read i
 do
  if ! [ "`echo $i|grep ' 2 Extended offline'`" ] ; then
   echo $i >>/var/log/${devname}.txt
  else
   break
  fi
 done </tmp/test.txt

 grep 'Reallocated_Sector_Ct\|Device Model\|Serial Number\|Raw_Read_Error_Rate\|Power_On_Hours\|Temperature_Celsius\|Seek_Error_Rate\|^# 1  ' /var/log/${devname}.txt >>/tmp/mail.txt
 if [ -s /var/log/${devname}.old.txt ] ; then
  echo ==========================================================>>/tmp/mail.txt
  echo 历史比较: >>/tmp/mail.txt
  diff -u /var/log/${devname}.old.txt  /var/log/${devname}.txt |grep -v "^ "|grep -v "Local Time is" >>/tmp/mail.txt
 fi
 cat /tmp/mail.txt |mail  -s " `hostname` 硬盘${devname} 测试报告" $email $1
done
