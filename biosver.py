#!/usr/bin/env python                                                                                                                                                                                                                                                     
import os,sys
import binascii as ba
#for i in range(0,len(sys.argv)):
#	print(sys.argv[i])
cmd1='ipmitool -I lanplus -H '+sys.argv[1]+' -U admin -P admin raw 0x0e 0x53'
ver = os.popen(cmd1).read().strip().replace('\n','').replace(' ','')[0:22]
bio = ba.a2b_hex(ver).decode().replace('\x00','')
print (bio)
