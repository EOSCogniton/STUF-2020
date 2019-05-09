#%% SKID PAD MODEL
# Ce programme donne une estimation de l'accéleration latérale maximale
# et du temps au skid-pad
# en fonction des paramètres de la voiture et des pneus

#%% TOOLS

from scipy.optimize import fsolve
import numpy as np
from math import pi, sqrt

#%% GENERAL DATAS

R_skidpad=15.25/2   # rayon du skid pad en m
g=9.81  # accélération de la pesanteur en m/s²
m_pilot=95 # masse du pilot en kg
h_pilot=0.4 # hauteur de centre de gravité du pilote en m

#%% CAR DATAS

tf=1.3     # voie avant (en m)
tr=1.15     # voie arrière (en m)

w=1.55    # empattement (en m)
xf = 0.5        # répartition du poids sur l'avant
xr = 1 - xf     # répartition du poids sur l'arrière

Df=0   # déportance sur l'avant (en N)
Dr=0    # déportance sur l'arrière (en N)

#%% TIRE DATAS

# Donnees extraites des modeles de GTE

# Pneus 13"
FZ=np.array([50,100,150,250,350])*g*0.453592 #0.453592 = conversion lbs en kg
FY=np.array([647.54,1296.98,1918.52,2904.13,3756.80])*0.453592


Y_poly=np.polyfit(FZ,FY,2)

# force d'adhérence latérale du pneu en fonction de la charge
def Y(z):
    return np.polyval(Y_poly,z)


#%% RESOLUTION

# Le but du programme est de calculer l'accélération latérale amax à laquelle
# l'équilibre de la voiture est rompu, c'est-à-dire l'équilibre en force et en moment.
# La fonction FORCE donne le bilan des forces selon la direction parallèle au rayon du
# virage, amax_force est l'accelération a telle que FORCE(a)=0, ce qui correspond au cas
# ou les 2 trains de la voiture dérapent simultanément.
# La fonction torque donne le bilan des moments autour de l'axe vertical,
# amax_force est l'accelération a telle que TORQUE(a)=0, ce qui correspond au
# cas ou un des trains de la voiture dérape (train avant ou arrière).
# On choisit le minimu de ces deux valeurs et on obtient l'accélération maximale telle
# que la voiture ne dérape pas

MASS=np.linspace(200,250,50)        #liste des masses
H=np.linspace(0.05,0.6,50)          #liste des hauteurs du centre de gravité
ACC=np.zeros([len(MASS),len(H)])
TIME=np.zeros([len(MASS),len(H)])

Aodg=10  #une accélération en ordre de grandeur pour initier la fonction fsolve qui trouve le zéro de FORCE et TORQUE

for i in range(len(MASS)):
    for j in range(len(H)):
        
        m=MASS[i]+m_pilot
        h=(MASS[i]/m)*H[j]+(m_pilot/m)*h_pilot
        
        
        def FORCE(a):
            Zfe=xf*m*g/2 + Df/2 + xr*m*a*h/tf
            Zfi=xf*m*g/2 + Df/2 - xr*m*a*h/tf
            Zre=xr*m*g/2 + Dr/2 + xf*m*a*h/tr
            Zri=xr*m*g/2 + Dr/2 - xf*m*a*h/tr
            return Y(Zfe)+Y(Zfi)+Y(Zre)+Y(Zri) - m*a
        def TORQUE(a):
            Zfe=xf*m*g/2 + Df/2 + xr*m*a*h/(2*tf)
            Zfi=xf*m*g/2 + Df/2 - xr*m*a*h/(2*tf)
            Zre=xr*m*g/2 + Dr/2 + xf*m*a*h/(2*tr)
            Zri=xr*m*g/2 + Dr/2 - xf*m*a*h/(2*tr)
            return xf*(Y(Zre)+Y(Zri))-xr*(Y(Zfe)+Y(Zfi))
        
        amax_force = fsolve(FORCE,Aodg)
        amax_torque = fsolve(TORQUE,Aodg)
        amax = min(amax_force,amax_torque)
        ACC[i,j] = amax/g
        #TIME[i,j]=2*pi*sqrt((R_skidpad+max(tf,tr)/2)*g/amax)
    



#%% PLOT

import matplotlib.pyplot as plt

plt.clf()
cont=plt.contour(MASS, H, ACC,10)
plt.clabel(cont)
plt.xlabel('Masse (kg)')
plt.ylabel('hauteur de centre de gravité (m) ')
plt.show()
