%Permet de tracer le max de FY et FX en fonction de la charge 
%% Initialisation
clear all; close all; clc;
tipe = 'B';
round = 5; 
mm = 'HB13';
rim_dim = 7;
pression = '14';
vitesse = 25;
carrossage = 2;
%% FY en fonction de la charge Fz
charge = [50 100 150 250 350];
FY_max=0*charge; % meme taille
SA=(-13:0.05:13);
for i=1:length(charge)
    coef=coeff_approximation_Fy(tipe,round,mm,rim_dim,pression,vitesse,charge(i),carrossage);
    FY=polyval(coef,SA);
    FY_max(i)=max(FY);
end

charge = charge*0.453592*9.81; % de lbs en Kg en N;

figure
plot(charge,FY_max,'*-')
titl = strcat('essai:',tipe,int2str(round),' tire:',mm,' - ',int2str(rim_dim),' pres(psi):',pression,' vit(mph):',int2str(vitesse),' carr:',int2str(carrossage));
title(titl)
xlabel('Charge verticale Fz (N)')
ylabel('FY max (N)')

%% EXPORT resut to json for python

fid = fopen('export/Fy_Fz.json','wt');
fprintf(fid, jsonencode([FY_max;charge]));
fclose(fid);

%% FX en fonction de la charge Fz
charge=[50 150 250 350];
SA_X = 3;
FX_max=0*charge;
SL=(-0.15:0.01:0.15);
for i=1:length(charge)
    coef=coeff_approximation_Fx(tipe,round,mm,rim_dim,pression,vitesse,charge(i),carrossage,SA_X);
    FX=polyval(coef,SL);
    FX_max(i)=max(FX);
end

charge = charge*0.453592*9.81; % de lbs en Kg en N;

figure
plot(charge,FX_max)
titl = strcat('essai:',tipe,int2str(round),' tire:',mm,' - ',int2str(rim_dim),' pres(psi):',pression,' vit(mph):',int2str(vitesse),' carr:',int2str(carrossage));
title(titl)
xlabel('Charge verticale (N)')
ylabel('FX max (N)')