#!/bin/sh

cat /root/bmcip/ip |grep -i "t1dmg" >/root/bmcip/gpu
cat ip|grep -i t1dmg |awk '{print $2}'|sed 's/.*192/192/' > /root/bmcip/gpuip
>/root/bmcip/gpumac
for i in `cat /root/bmcip/gpuip`
  do
	  if ping $i -c 2
	  then  
	  (arp $i|grep "no entry")&&(echo "none">>/root/bmcip/gpumac)
	  arp $i |grep ":"|awk '{print $3}' >>/root/bmcip/gpumac
	  elif ping $i -c 8
         then
	  (arp $i|grep "no entry")&&(echo "none">>/root/bmcip/gpumac)
	  arp $i |grep ":"|awk '{print $3}' >>/root/bmcip/gpumac
      else 
			 sed -i -e "/$i/d" /root/bmcip/gpu
		  continue
        fi
  done
>/root/bmcip/user
for i in `cat /root/bmcip/gpumac`
do
	(cat /root/bmcip/ulist|grep $i >>/root/bmcip/user)||(echo 'none' >>/root/bmcip/.user)
done
cat head1 >/var/www/html/product/gpu.html
cat ip|grep "BMC IP" >>/var/www/html/product/gpu.html
paste /root/bmcip/gpu /root/bmcip/user  >>/var/www/html/product/gpu.html
echo "</pre>" >>/var/www/html/product/gpu.html
echo "</div>" >>/var/www/html/product/gpu.html
sed -i "9a Update Time:`date`" /var/www/html/product/gpu.html
