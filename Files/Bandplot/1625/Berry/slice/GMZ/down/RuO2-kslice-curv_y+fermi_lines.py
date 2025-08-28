import pylab as pl
import numpy as np
from scipy import interpolate
from collections import OrderedDict
import matplotlib.pyplot as plt

# Set better default figure size and DPI for visibility
plt.rcParams['figure.figsize'] = (10, 8)
plt.rcParams['figure.dpi'] = 300
plt.rcParams['font.size'] = 12
 
points = np.loadtxt('RuO2-kslice-coord.dat')
# Avoid numerical noise
points_x=np.around(points[:,0],decimals=10)
points_y=np.around(points[:,1],decimals=10)
num_pt=len(points)
 
area=    0.981404
 
square= False                    
 
if square:
  x_coord=list(OrderedDict.fromkeys(points_x))
  y_coord=list(OrderedDict.fromkeys(points_y))
  dimx=len(x_coord)
  dimy=len(y_coord)
else:
  xmin=np.min(points_x)
  ymin=np.min(points_y)
  xmax=np.max(points_x)
  ymax=np.max(points_y)
  a=np.max(np.array([xmax-xmin,ymax-ymin]))
  num_int=int(round(np.sqrt(num_pt*a**2/area)))
  xint = np.linspace(xmin,xmin+a,num_int)
  yint = np.linspace(ymin,ymin+a,num_int)
 
# Energy level for isocontours (typically the Fermi level)
ef=   12.252300
 
bands=np.loadtxt('RuO2-kslice-bands.dat')
numbands=bands.size//num_pt
if square:
  bbands=bands.reshape((dimy,dimx,numbands))
  for i in range(numbands):
    Z=bbands[:,:,i]
    pl.contour(x_coord,y_coord,Z,[ef],colors='red',linewidths=2)
else:
  bbands=bands.reshape((num_pt,numbands))
  bandint=[]
  grid_x, grid_y = np.meshgrid(xint,yint)
  for i in range(numbands):
    bandint.append(interpolate.griddata((points_x,points_y), bbands[:,i], (grid_x,grid_y), method='nearest'))
    pl.contour(grid_x,grid_y,bandint[i],[ef],colors='red',linewidths=2)
 
outfile = 'RuO2-kslice-curv_y.pdf'
 
val = np.loadtxt('RuO2-kslice-curv.dat', usecols=(1,))
 
val_log=np.array([np.log10(abs(elem))*np.sign(elem) if abs(elem)>10 else elem/10.0 for elem in val])
 
if square: 
  Z=val_log.reshape(dimy,dimx)
  mn=int(np.floor(Z.min()))
  mx=int(np.ceil(Z.max()))
  # Create more levels for better color differentiation
  num_levels = 50
  levels = np.linspace(mn, mx, num_levels)
  cs = pl.contourf(x_coord,y_coord,Z,levels,origin='lower',cmap='RdBu_r',extend='both')
  #pl.imshow(Z,origin='lower',extent=(min(x_coord),max(x_coord),min(y_coord),max(y_coord)))
else: 
  grid_x, grid_y = np.meshgrid(xint,yint)
  valint = interpolate.griddata((points_x,points_y), val_log, (grid_x,grid_y), method='nearest')
  mn=int(np.floor(valint.min()))
  mx=int(np.ceil(valint.max()))
  # Create more levels for better color differentiation
  num_levels = 50
  levels = np.linspace(mn, mx, num_levels)
  cs = pl.contourf(grid_x,grid_y,valint,levels,cmap='RdBu_r',extend='both')
  #pl.imshow(valint,origin='lower',extent=(min(xint),max(xint),min(yint),max(yint)))
 
ticklabels=[]
# Keep the original tick positions for the colorbar
ticks=range(mn,mx+1)
for n in ticks:
 if n<0: 
  ticklabels.append('-$10^{%d}$' % abs(n))
 elif n==0:
  ticklabels.append(' $%d$' %  n)
 else:
  ticklabels.append(' $10^{%d}$' % n)
 
cbar=pl.colorbar(cs)
cbar.set_ticks(ticks)
cbar.set_ticklabels(ticklabels)
cbar.set_label('Berry Curvature (y-component)', fontsize=14, rotation=270, labelpad=20)
 
# Add title and improve overall appearance
pl.title('RuO2 K-slice Berry Curvature (y-component) with Fermi Lines', fontsize=16, pad=20)

ax = pl.gca()
ax.set_aspect('equal')  # Make the plot square for better visibility
ax.xaxis.set_visible(False)
ax.yaxis.set_visible(False)
 
# Add a border around the plot
for spine in ax.spines.values():
    spine.set_visible(True)
    spine.set_linewidth(2)
    spine.set_edgecolor('black')
 
pl.savefig(outfile,bbox_inches='tight',dpi=300)
pl.tight_layout()  # Improve layout spacing
pl.show()
