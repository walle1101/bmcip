#!/bin/sh
function br()
{
	cat $1|while read line
        do
	        echo "${line}"     
			a=`echo "${line}"|awk '{print $2}'|sed 's/.*172/172/'`
			(python config.py $a)||(echo " ")
	        echo -e "\n"
            done
}
printf '%37s\n' "Manufactue" >.MFG.txt
printf '%30s\n' "Board" >.BMFG.txt
printf '%6s\n' "BMC IP" >.ip.txt
printf '%20s\n' "Other" >.tag.txt
printf '%27s\n' "NodeID" >.nid.txt
printf '%31s\n' "BMC MAC Address" >.mac
printf '%23s\n' "BMC | BIOS    " >.bmcversion
printf '%1s\n' " " >.biosversion

for j in $(seq 0 1)
do

for i in $(seq 1 254)
do
rm -rf finish
(nmap -sU 172.17.$j.$i -p 623 |grep "open|filtered"&>/dev/null)&&(nmap -sT 172.17.$j.$i -p 623 |grep "open"&>/dev/null)&&(ipmitool -I lanplus -H 172.17.$j.$i -U admin -P admin raw 0x00 0x01 >/dev/null )&&(touch finish)
sleep 1
if [ -f finish ]
then
a=`(ipmitool -I lanplus -H 172.17.$j.$i -U admin -P admin raw 0x04 0x2d 0x55 |cut -b 3)`
if [ ! -n "$a" ]
then 
printf '%25s\n' "na" >> .nid.txt
else
printf '%30s\n' $a >> .nid.txt
fi
b=`ipmitool -I lanplus -H 172.17.$j.$i -U admin -P admin fru |grep "Product Manufacturer" |sed 's/.*: //'`
printf '%30s\n' "$b" >> .MFG.txt
c=`ipmitool -I lanplus -H 172.17.$j.$i -U admin -P admin fru |grep "Board Product" |sed 's/.*: //'`
printf '%30s\n' $c >> .BMFG.txt
d=`ipmitool -I lanplus -H 172.17.$j.$i -U admin -P admin fru |grep "Product Asset Tag" |sed 's/.*: //'`
echo "BMC `ipmitool -I lanplus -H 172.17.$j.$i   -U admin -P admin mc info|grep "Firmware Revision" `.`ipmitool -I lanplus -H 172.17.$j.$i   -U admin -P admin mc info |grep -A1 'Aux'|grep 0x|sed 's/.*0x//'`"|sed s'/.*: //' >>.bmcversion
python biosver.py 172.17.$j.$i >>.biosversion
printf '%30s\n' $d >> .tag.txt
e=`ipmitool -I lanplus -H 172.17.$j.$i -U admin -P admin raw  0x0c 0x02 0x01 0x05 0x00 0x00|awk '{print $2,$3,$4,$5,$6,$7}'|sed 's/ /:/g'`
printf '%25s\n' $e >>.mac
echo -e "\033[32m 172.17.$j.$i\033[0m " 
date >> listip
echo " 172.17.$j.$i " >>listip 
printf '%30s\n' 172.17.$j.$i 
printf '%30s\n' "<a href="https://172.17.$j.$i" target="_blank">172.17.$j.$i</a>" >> .ip.txt
else
pkill ipmitool &>/dev/null
rm -rf finish
continue
fi
done
done
paste .ip.txt .bmcversion .biosversion .MFG.txt .BMFG.txt .nid.txt .tag.txt .mac >.ip.xls
paste .ip.txt .bmcversion .biosversion .MFG.txt .BMFG.txt .tag.txt .mac >.ip
#rm -rf *.txt
cat head >/var/www/html/index.html
#cat .ip >>/var/www/html/index.html
br .ip >>/var/www/html/index.html
echo "</pre>" >>/var/www/html/index.html
echo "</div>" >>/var/www/html/index.html
sed -i "13a Update Time:` date "+%Y-%m-%d %H:%M:%S"`" /var/www/html/index.html


cat head1 >/var/www/html/product/sizixing.html
cat .ip.xls|grep "BMC IP" >>/var/www/html/product/sizixing.html
cat /root/bmcip/.ip.xls |grep -i "t1dmt" >i
br i>>/var/www/html/product/sizixing.html
cat /root/bmcip/.ip.xls |grep -i "g2dcn">i
br i>>/var/www/html/product/sizixing.html
echo "</pre>" >>/var/www/html/product/sizixing.html
echo "</div>" >>/var/www/html/product/sizixing.html
sed -i "13a Update Time:`date`" /var/www/html/product/sizixing.html


cat head1 >/var/www/html/product/L.html
cat .ip|grep "BMC IP" >>/var/www/html/product/L.html
cat /root/bmcip/.ip |grep -i "t1dm-e2"|grep -iv "t1dmt" >i
br i>>/var/www/html/product/L.html
echo "</pre>" >>/var/www/html/product/L.html
echo "</div>" >>/var/www/html/product/L.html
sed -i "13a Update Time:`date`" /var/www/html/product/L.html


cat head1 >/var/www/html/product/guochan.html
cat .ip|grep "BMC IP" >>/var/www/html/product/guochan.html
cat /root/bmcip/.ip |grep -i "T1SMSW">i
br i>>/var/www/html/product/guochan.html
echo "</pre>" >>/var/www/html/product/guochan.html
echo "</dic>" >>/var/www/html/product/guochan.html
sed -i "13a Update Time:`date`" /var/www/html/product/guochan.html


cat head1 >/var/www/html/product/silu.html
cat .ip|grep "BMC IP" >>/var/www/html/product/silu.html
cat /root/bmcip/.ip |grep -i "t1qm">i
br i>>/var/www/html/product/silu.html
echo "</pre>" >>/var/www/html/product/silu.html
echo "</div>" >>/var/www/html/product/silu.html
sed -i "13a Update Time:`date`" /var/www/html/product/silu.html

cat head1 >/var/www/html/product/gpu.html
cat .ip|grep "BMC IP" >>/var/www/html/product/gpu.html
#cat /root/bmcip/.ip |grep -i "t1dmg" >>/var/www/html/product/gpu.html
cat /root/bmcip/.ip |grep -i "t1dmg" >.gpu
/root/bmcip/gmode.sh
paste .gpu .gmode >i 
br i>>/var/www/html/product/gpu.html
echo " <img src="config1.png" width="504" height="713" />" >>/var/www/html/product/gpu.html
echo "</pre>" >>/var/www/html/product/gpu.html
echo "</div>" >>/var/www/html/product/gpu.html
sed -i "13a Update Time:`date`" /var/www/html/product/gpu.html
/root/bmcip/cgpu.sh
