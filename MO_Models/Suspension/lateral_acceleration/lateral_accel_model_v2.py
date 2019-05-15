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
rho = 1.18415 # masse volumique de l'air en kg/m³
m_pilot=75 # masse du pilot en kg
h_pilot=0.4 # hauteur de centre de gravité du pilote en m

#%% CAR DATAS

m= 185 + 15
h= 0.4

tf= 1.24     # voie avant (en m)
tr= 1.165     # voie arrière (en m)

w=1.55    # empattement (en m)
xf = 0.5        # répartition du poids sur l'avant
xr = 1 - xf     # répartition du poids sur l'arrière

## Aero

S = 1.14 #surface effective pour la déportance en m²
Cy = 2.13 #coefficient de portance


#%% TIRE DATAS

# Donnees extraites des modeles de GTE

# Le coefficient 2/3 est un coeff donné par les testeurs de pneus: ils estiment
# qu'une vraie piste adhère 2/3 fois moins que leur banc d'essai

FZ=np.array([0,667.233,444.822,1112.055,222.411,1556.877])

# Pneus 10" pour un slip angle de -1.6°
FY=np.array([0,620.662,460.466,876.499,274.269,765.804])*2/3

#Pneus 10" pour un slip angle optimal
FY=np.array([0,1519.182,1073.523,2320.305,583.316,1923.809])*2/3

# Pneus 13" pour un slip angle de -1.6°
FY=np.array([0,923.995,714.693,1111.856,420.092,1114.576])*2/3

#Pneus 13" pour un slip angle optimal
FY=np.array([0,1783.995,1233.106,2692.902,676.343,3363.065])*2/3



Y_poly=np.polyfit(FZ,FY,4)

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

def FORCE(a):
    Zfe=xf*m*g/2 + 1/8*Cy*rho*S*a*(R_skidpad+max(tf,tr)) + xr*m*a*h/tf
    Zfi=xf*m*g/2 + 1/8*Cy*rho*S*a*(R_skidpad+max(tf,tr)) - xr*m*a*h/tf
    Zre=xr*m*g/2 + 1/8*Cy*rho*S*a*(R_skidpad+max(tf,tr)) + xf*m*a*h/tr
    Zri=xr*m*g/2 + 1/8*Cy*rho*S*a*(R_skidpad+max(tf,tr)) - xf*m*a*h/tr
    return Y(Zfe)+Y(Zfi)+Y(Zre)+Y(Zri) - m*a

amax = fsolve(FORCE,g)[0]
acc = amax/g
time=2*pi*sqrt((R_skidpad+max(tf,tr)/2)/amax)
    
print('accélération:',acc,'g')
print('temps au skid pad:',time,'s')
print('score au skid-pad:',score(time))