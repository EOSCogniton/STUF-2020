function [coefficient] = coeff_approximation_Fx_10(carrossage,charge,rim_diameter,pression,round,SA)

%attention, cette fonction ne marche que pour les pneu Hoosier de 13 pouces
%(ceux choisi par l'écurie)

r=int2str(round);
IA=int2str(carrossage); %Doit être un entier compris dans la liste suivante : [0 1 2 3 4] 
Fz=int2str(charge);  %Doit être un entier compris dans la liste suivante : [50 100 150 250 350]
rim_dim=int2str(rim_diameter); %doit être un entier égal à 6 ou 7 pour le round 5
P=pression;  %doit être un STRING compris dans la liste suivante : ['8','10','12i', '12f', '14']
SA=int2str(SA);

load('Round5_Brake_all_run.mat');   %permet d'importer la grande matrice dans le workplace
fichier=strcat('B',r,'_HD10',rim_dim,'_',P,'_25_',Fz,'_',IA,'_',SA);   %nom du pneu
fichier=eval(fichier);       %permet d'accéder à la variable ayant comme nom 'fichier' , si on fait pas ça ça ne marche pas
Fx_discret=fichier.FX;      %On accède à MZ
SL=fichier.SL;
coefficient=polyfit(SL,Fx_discret,20);     %permet d'approximer la courbe de MZ en fonction de SA par un polynome de degré 15.

% % Permet de tracer la courbe pour s'assurer de la pertinance de l'approximation
% figure
% hold on
% plot(SL,Fx_discret,'+')
% plot(SL,polyval(coefficient,SL))