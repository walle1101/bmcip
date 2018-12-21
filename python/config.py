#!/usr/bin/env python                                                                                                                                                                                                                                                     
#encoding: utf-8
import os,sys
import binascii as ba
#for i in range(0,len(sys.argv)):
#	print(sys.argv[i])
cmd1='ipmitool -I lanplus -H '+sys.argv[1]+' -U admin -P admin raw 0x0e 0x57'
ver0 = os.popen(cmd1).read().strip().replace(' ','').replace('\n','')
cmd2='ipmitool -I lanplus -H '+sys.argv[1]+' -U admin -P admin raw 0x0e 0x59 0x00'
ver = os.popen(cmd2).read().strip().replace(' ','').replace('\n','')
ver1 = ver[8:208]
ver2 = ver[1:2]
cpu = ba.a2b_hex(ver1).decode()+' x'+ver0[1]



cmd3='ipmitool -I lanplus -H '+sys.argv[1]+' -U admin -P admin raw 0x0e 0x61 0x00'
ver = os.popen(cmd3).read().strip().replace(' ','').replace('\n','')
ver3 = ver[18:58]
ver4 = str(int(ver[10:12]+ver[8:10],16))
ver5 = str(int(ver[6:8]+ver[4:6],16))
ver6 = int(ver0[2:4],16)
mem =  ba.a2b_hex(ver3).decode()+' '+ver5+'GB '+ver4+'MHz'+' x'+str(ver6)
#print ("配置:"+cpu+"    "+mem+'  <a href=javascript:openNewWin("/func/detail.html?id='+sys.argv[1]+'")>详细配置</a>')
print ("<font  color='blue'; size='1'>"+cpu+"____"+mem+'</font>   <a href=javascript:openNewWin("/func/detail.html?id='+sys.argv[1]+'")>详细</a>')

