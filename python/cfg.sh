#########################################################################
# File Name: cfg.sh
# Author: walle
# mail: wuzhongpin@ttyinfo.com
# Created Time: Mon 05 Nov 2018 05:40:38 PM CST
#########################################################################
#!/bin/sh
cat $1|while read line
do
echo "${line}"|grep href     
if  [[ $? -eq 0 ]]
then
a=`echo "${line}"|awk '{print $3}'|sed 's/.*192/192/'`
(python config.py $a)||(echo " ")
echo -e "\n"
else
	continue
fi
done
