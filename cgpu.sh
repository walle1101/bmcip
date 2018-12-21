#########################################################################
# File Name: cgpu.sh
# Author: walle
# mail: wuzhongpin@ttyinfo.com
# Created Time: Fri 21 Sep 2018 08:39:52 AM CST
#########################################################################
#!/bin/sh
cd /root/bmcip/

a=`cat .ip |grep -i t1dmg|awk '{print $10}'`
for i in $a
do
	j=`cat ulist|grep $i`
	([ ! $j ])||(sed  -i "s/$i/$j/" /var/www/html/product/gpu.html)
done
