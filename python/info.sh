#########################################################################
# File Name: 1.sh
# Author: walle
# mail: wuzhongpin@ttyinfo.com
# Created Time: Sat 03 Nov 2018 05:29:22 PM CST
#########################################################################
#!/bin/sh
rm -rf finish
(nmap -sU 192.168.$1.$2 -p 623 |grep "open|filtered"&>/dev/null)&&(ipmitool -I lanplus -H 192.168.$1.$2 -U admin -P admin raw 0x00 0x01 >/dev/null )&&(touch finish)
sleep 1
if [ -f finish ]
then
board=`ipmitool -I lanplus -H 192.168.$1.$2 -U admin -P admin fru |grep "Board Product" |sed 's/.*: //'`
sleep 0.1
 if [ ! -n "$board" ]
 then
	 board=' '
 fi
manufac=`ipmitool -I lanplus -H 192.168.$1.$2 -U admin -P admin fru |grep "Product Manufacturer" |sed 's/.*: //'`
 if [ ! -n "$manufac" ]
 then
	 manufac=' '
 fi
sleep 0.1
asset=`ipmitool -I lanplus -H 192.168.$1.$2 -U admin -P admin fru |grep "Product Asset Tag" |sed 's/.*: //'`
 if [ ! -n "$asset" ]
 then
	 asset=' ' 
 fi
sleep 0.1
mac=`ipmitool -I lanplus -H 192.168.$1.$2 -U admin -P admin lan print|grep 'MAC Address'|awk '{print $4}'`
#catch info
vbios=`python biosver.py 192.168.$1.$2`
 if [ ! -n "$vbios" ]
 then
	 vbios=' '
 fi
cfg=`python config.py 192.168.$1.$2`
 if [ ! -n "$cfg" ]
 then
	 cfg='<a href=javascript:openNewWin("/func/detail.html?id=192.168.$1.$2")>重试</a>'
 fi
vbmc=`ipmitool -I lanplus -H 192.168.$1.$2   -U admin -P admin mc info|grep "Firmware Revision" `.`ipmitool -I lanplus -H 192.168.$1.$2   -U admin -P admin mc info |grep -A1 'Aux'|grep 0x|sed 's/.*0x//'`
vbmc=`echo $vbmc|sed s'/.*: //'`
 if [ ! -n "$vbmc" ]
 then
	 vbmc=' '
 fi
echo "192.168.$1.$2 " 
echo  "<a href="http://192.168.$1.$2" target="_blank">192.168.$1.$2</a>" 
echo "$vbios"
echo "$vbmc"
echo "$board"
echo "$manufac"
echo "$mac"
echo "$asset"
echo "$cfg"
else
pkill ipmitool &>/dev/null
rm -rf finish
echo 'pass'
fi
