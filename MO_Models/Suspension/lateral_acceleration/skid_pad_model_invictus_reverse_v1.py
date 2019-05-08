#%% SKID PAD MODEL
# Ce programme donne une estimation du temps au tour au skid pad (rayon de 15.25m)
# en fonction des paramètres de la voiture et des pneus

#%% TOOLS

from scipy.optimize import fsolve
import numpy as np
from math import pi

    
def dichotomie(f,a,b,e):
    while b-a>e:
        m=(a+b)/2
        if f(m)*f(a)<=0:
            b=m
        else:
            a=m
    return m


#%% GENERAL DATAS

R_skidpad=15.25/2
g=9.81
m_pilot=95
k_pilot=0.3


#%% TIRE DATAS

# Donnees extraites des modeles de GTE
FZ=np.array([50,100,150,250,350])*g*0.453592 #0.453592 = conversion lbs en kg
FY=np.array([647.54,1296.98,1918.52,2904.13,3756.80])*0.453592

µ=FY/FZ
µ_poly=np.polyfit(FZ,µ,2)

#coefficient de friction latéral du pneu (selon l'axe y)
def µy(z):
    return np.polyval(µ_poly,z)


#%% RESOLUTION

# Le but du programme est de calculer la vitesse Vmax à laquelle
# le train dérape. Vmax est donc la vitesse à la limite
# du glissement, c'est à dire lorsque la force centrifuge égale la
# somme des forces d'adhérences des pneus intérieur et extérieur.
# La fonction PHI donne la somme totale des forces dans la direction
# transversale (y) en fonction de la vitesse pour les deux trains de
# la voiture (avant et arrière), on recherche donc Vmax tel que PHI(Vmax)=0

MASS=np.linspace(180,250,200)        #liste des masses
K=np.linspace(0.05,0.8,200)             #liste des rapports hauteur C.G. / voie
TIME=np.zeros([len(MASS),len(K)])

Vodg=10

for i in range(len(MASS)):
    for j in range(len(K)):
        def PHI(v):
            a=v**2/R_skidpad
            m=MASS[i]+m_pilot
            k=(MASS[i]/m)*K[j]+(m_pilot/m)*k_pilot
            Fze=m*(g/4+a*k/2)           
            Fzi=m*(g/4-a*k/2)           
            return 2*(Fze*µy(Fze)+Fzi*µy(Fzi))-m*a
        Vmax=fsolve(PHI,Vodg)
        time=2*pi*R_skidpad/Vmax
        TIME[i,j] = time



#%% PLOT

from mpl_toolkits.mplot3d import Axes3D
import matplotlib.pyplot as plt
from matplotlib import cm
from matplotlib.ticker import LinearLocator, FormatStrFormatter
import numpy as np

plt.clf()

cont=plt.contour(MASS, K, TIME,15)
plt.clabel(cont)
plt.xlabel('Masse (kg)')
plt.ylabel('Rapport h/t')

plt.show()
