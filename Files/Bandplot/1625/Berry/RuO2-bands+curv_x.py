import pylab as pl
import numpy as np
from matplotlib.gridspec import GridSpec
tick_labels=[]
tick_locs=[]
tick_labels.append('$\Gamma$')
tick_locs.append(0)
tick_labels.append(' X'.strip())
tick_locs.append(    0.691905)
tick_labels.append(' R'.strip())
tick_locs.append(    1.694871)
tick_labels.append(' Z'.strip())
tick_locs.append(    2.386776)
tick_labels.append('$\Gamma$')
tick_locs.append(    3.389743)
tick_labels.append(' M'.strip())
tick_locs.append(    4.368243)
tick_labels.append(' A'.strip())
tick_locs.append(    5.371210)
tick_labels.append(' Z'.strip())
tick_locs.append(    6.349711)
fig = pl.figure()
gs = GridSpec(2, 1,hspace=0.00)
axes1 = pl.subplot(gs[0, 0:])
data = np.loadtxt('RuO2-bands.dat')
x=data[:,0]
y=data[:,1]-   12.252300
pl.scatter(x,y,color='k',marker='+',s=0.1)
pl.xlim([0,max(x)])
pl.ylim([-0.65,0.65]) # Adjust this range as needed
pl.plot([tick_locs[0],tick_locs[-1]],[0,0],color='black',linestyle='--',linewidth=0.5)
pl.xticks(tick_locs,tick_labels)
for n in range(1,len(tick_locs)):
   pl.plot([tick_locs[n],tick_locs[n]],[pl.ylim()[0],pl.ylim()[1]],color='gray',linestyle='-',linewidth=0.5)
pl.ylabel('Energy$-$E$_F$ [eV]')
pl.tick_params(axis='x',which='both',bottom='off',top='off',labelbottom='off')
axes2 = pl.subplot(gs[1, 0:])
data = np.loadtxt('RuO2-curv.dat')
x=data[:,0]
y=data[:,1]
pl.plot(x,y,color='k')
pl.xlim([0,max(x)])
pl.ylim([min(y)-0.025*(max(y)-min(y)),max(y)+0.025*(max(y)-min(y))])
pl.xticks(tick_locs,tick_labels)
for n in range(1,len(tick_locs)):
   pl.plot([tick_locs[n],tick_locs[n]],[pl.ylim()[0],pl.ylim()[1]],color='gray',linestyle='-',linewidth=0.5)
pl.ylabel('$-\Omega_x(\mathbf{k})$  [ bohr$^2$ ]')
outfile = 'RuO2-bands+curv_x.pdf'
pl.savefig(outfile,bbox_inches='tight')
pl.show()
