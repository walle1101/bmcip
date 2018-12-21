#########################################################################
# File Name: 1.sh
# Author: walle
# mail: wuzhongpin@ttyinfo.com
# Created Time: Fri 28 Sep 2018 03:07:37 PM CST
#########################################################################
#!/bin/sh
 b=`cat ../.ip|grep -i t1dmg |awk '{print $2}'|sed 's/.*192/192/'`
 for k in $b
  do
	  a=`(python biosver.py $k)||(echo "time out")`
	  echo $a
done
