function [coefficient] = coeff_approximation_Fx(type,round,mm,rim_diameter,pression,vitesse,charge,carrossage,SA)
% ATTENTION: chercher les valeurs admissibles dans le fichier de nomenclature
% type       (str): type du test, C: cornering, B braking
% round      (int): 5 ou 6 
% mm         (str): make and model, voir focher nomenclature EX: HB13
% rim_dim    (int): diametre de la jante EX: 6 ou 7 pour le round 5
% pression   (str): pression ['8','10','12i', '12f', '14']
% vitesse    (int): vitesse du test [15, 25, 45]
% charge     (int): charge verticale en lbs (Fz)  [50 100 150 250 350]
% carrossage (int): inclination angle (IA) [0 1 2 3 4] 
% SA         (int): slip angle 

r=int2str(round);
IA=int2str(carrossage);
Fz=int2str(charge);
rim_dim=int2str(rim_diameter); 
P = pression;
v = int2str(vitesse);
SA=int2str(SA);

% importer la matrice des donnees 
filename = strcat(r,'_',type,'_all.mat')
load(filename);
% nom du pneu a afficher
fichier = strcat(type,r,'_',mm,rim_dim,'_',P,'_',v,'_',Fz,'_',IA,'_',SA)
%permet d'accéder à la variable ayant comme nom 'fichier'
fichier=eval(fichier);
% calcul en partant de FX
Fx_discret=fichier.FX;
SL=fichier.SL;
% approximation polynome de degré 20
coefficient=polyfit(SL,Fx_discret,20);

% % Permet de tracer la courbe pour s'assurer de la pertinance de l'approximation
% figure
% hold on
% plot(SL,Fx_discret,'+')
% plot(SL,polyval(coefficient,SL))