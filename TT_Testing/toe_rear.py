# -*- coding: utf-8 -*-
"""
Created on Mon Jun 14 00:44:28 2021

@author: Martin Kawczynski
"""

def grip_r(toe,r):
    
    theta_ro=np.arctan(-xr/(r+tr/2))
    theta_ri=np.arctan(-xr/(r-tr/2))
    theta_r=np.arctan(-xr/r)
    
    SA_ro=theta_ro-toe
    SA_ri=theta_ri+toe
    
    Fy_ro=Fy(1300,SA_ro,CAMBER_r(RG*1.2*g))
    Fy_ri=Fy(100,SA_ri,-CAMBER_r(RG*1.2*g))
    
    return Fy_ro+Fy_ri


TOE=np.linspace(-2,+2,50)



plt.clf()
plt.plot(TOE,grip_r(TOE*pi/180,(15.25+tr+0.205)/2))
plt.xlabel('Toe (°)')
plt.ylabel('Rear Grip (N)')
plt.grid(True)

plt.show()

