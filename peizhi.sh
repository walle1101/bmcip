#########################################################################
# File Name: asciitostr.sh
# Author: walle
# mail: wuzhongpin@ttyinfo.com
# Created Time: 2018年10月09日 星期二 00时06分43秒
#########################################################################
#!/bin/sh
function a2s()
{
for i in `echo $1|sed 's/ /\n/g'`
do
	printf "\x$i"
done
}
num=`ipmitool -I lanplus -H $1 -U admin -P admin raw 0x0e 0x57`

cpunum=${num:2:1}
memnum=`printf %d 0x${num:4:2}`

echo "==================================CPUx$cpunum================================="
for ((i=0;i<$cpunum;i++));
do
   let j=i+1
   a=`ipmitool -I lanplus -H $1 -U admin -P admin raw 0x0e 0x59 0x$i`
   while [ 1 ]
   do
   if  test -z "$a";
   then
		   sleep 0.3
		   a=`ipmitool -I lanplus -H $1 -U admin -P admin raw 0x0e 0x61 0x$seq`
	   else
		   break
	fi
done
   b=`echo $a|xargs`
   c=${b:12:300}
   c=`a2s "$c"`
   echo "Socket$j: $c"
done
echo "==================================Memoryx$memnum================================="
for ((i=0;i<$memnum;i++));
do
   let j=i+1
   j=`printf "%2s" $j`
   seq=`printf %x $i`
   a=`ipmitool -I lanplus -H $1 -U admin -P admin raw 0x0e 0x61 0x$seq`
   while [ 1 ]
   do
   if  test -z "$a";
   then
		   sleep 0.3
		   a=`ipmitool -I lanplus -H $1 -U admin -P admin raw 0x0e 0x61 0x$seq`
	   else
		   break
	fi
done
   b=`echo $a|xargs`
   c=${b:27:60} #brand
   c=`a2s "$c"`
   d=${b:18:9} #location
   d=`a2s "$d"`
   e=${b:15:2}${b:12:2} #speed
   e=`printf %d 0x$e`
   f=${b:9:2}${b:6:2} #size
   f=`printf %d 0x$f`
#   g=${b:3:3} #type
   g=`a2s "$g"`
   h=${b:87:57} #sn
   h=`a2s "$h"`
   echo "$j:$c  $f GB $e MHz CPU_$d SN:$h"
done
