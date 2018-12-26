#!/usr/bin/env python
import numpy as np
import pandas as pd
import time,sys,os,pickle
pd.set_option('max_colwidth', 200) 
pd.set_option('display.max_rows', None)
np.set_printoptions(threshold='nan')
arr = np.array(['ip','link','bios','bmc','borad','manufature','mac','asset tag','config'])
for i in [0,1]:
	for j in range(1,254):
			l1 = os.popen('sh info.sh '+str(i)+' '+str(j)).read().strip()
			if str(l1) == 'pass':
				pass
			else:
			    l0 = l1.replace('\n',',').split(',')
			    print(l0)
			    arr = np.vstack([arr,l0])
dfindex = pd.DataFrame(arr,columns=['ip','IP','Bios','Bmc','Board','Manufacture','Mac Address','Asset Tag','Config'])
op = open('./log/ip.log','wb')
pickle.dump(dfindex,op)
op.close()
df = dfindex.drop(['ip'],axis=1).drop(0)
df.to_html('1.html',escape=False,index_names=False,justify='left') 
os.popen('cat head > /var/www/html/index.html')
os.popen('cat 1.html >> /var/www/html/index.html')
os.popen("echo '</div>' >> /var/www/html/index.html")

t1dm = df[df.Board=='T1DM-E2'] 
t1dm.to_html('1.html',escape=False,index_names=False,justify='left') 
os.popen('cat head1 > /var/www/html/product/L.html')
os.popen('cat 1.html >> /var/www/html/product/L.html')
os.popen("echo '</div>' >> /var/www/html/product/L.html")

t1dmg = df[df.Board=='T1DMG'] 
t1dmg.to_html('1.html',escape=False,index_names=False,justify='left') 
os.popen('cat head1 > /var/www/html/product/gpu.html')
os.popen('cat 1.html >> /var/www/html/product/gpu.html')
os.popen("echo '</div>' >> /var/www/html/product/gpu.html")

#t1qm = df[df.Board=='T1QM'] 
#t1dm.to_html('1.html',escape=False,index_names=False,justify='left') 
#os.popen('cat head1 > /var/www/html/product/L.html')
#os.popen('cat 1.html >> /var/www/html/product/L.html')
#os.popen("echo '</div>' >> /var/www/html/product/L.html")

#g2dcn = df[df.Board=='G2DCN'] 
#t1dm.to_html('1.html',escape=False,index_names=False,justify='left') 
#os.popen('cat head1 > /var/www/html/product/L.html')
#os.popen('cat 1.html >> /var/www/html/product/L.html')
#os.popen("echo '</div>' >> /var/www/html/product/L.html")

