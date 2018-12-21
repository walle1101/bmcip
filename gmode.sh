#########################################################################
# File Name: 1.sh
# Author: walle
# mail: wuzhongpin@ttyinfo.com
# Created Time: Sat 22 Sep 2018 05:05:26 PM CST
#########################################################################
#!/bin/sh
#echo "模式">.gmode
>.gmode
b=`cat .ip|grep -i t1dmg |awk '{print $2}'|sed 's/.*192/192/'`
for k in $b
do
  #a=`python biosver.py $k`	
  c=`ipmitool -I lanplus -H $k -U admin -P admin raw 0x0e 0x76 00`
  if [[ $c -eq 01 ]]
    then
		  echo "————————————>级联" >>.gmode
  elif [[ $c -eq 02 ]]
    then
		  echo "————————————>通用" >>.gmode
  elif [[ $c -eq 03 ]]
    then 
		  echo "————————————>平衡" >>.gmode
  else
	     echo  "————————————>no stat">>.gmode
  fi
done
