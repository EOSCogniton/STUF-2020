function [coefficient] = coeff_approximation_Fy_10(carrossage,charge,rim_diameter,pression,round)

%attention, cette fonction ne marche que pour les pneu Hoosier de 13 pouces
%(ceux choisi par l'écurie)

r=int2str(round);
IA=int2str(carrossage); %Doit être un entier compris dans la liste suivante : [0 1 2 3 4] 
Fz=int2str(charge);  %Doit être un entier compris dans la liste suivante : [50 100 150 250 350]
rim_dim=int2str(rim_diameter); %doit être un entier égal à 6 ou 7 pour le round 5
P=pression;  %doit être un STRING compris dans la liste suivante : ['8','10','12i', '12f', '14']

load('Round6_Corner_all_run.mat');   %permet d'importer la grande matrice dans le workplace
fichier=strcat('C',r,'_HD10',rim_dim,'_',P,'_25_',Fz,'_',IA);   %nom du pneu
fichier=eval(fichier);       %permet d'accéder à la variable ayant comme nom 'fichier' , si on fait pas ça ça ne marche pas
Fy_discret=fichier.FY;      %On accède à MZ
SA=fichier.SA;
coefficient=polyfit(SA,Fy_discret,20);     %permet d'approximer la courbe de MZ en fonction de SA par un polynome de degré 15.

% % Permet de tracer la courbe pour s'assurer de la pertinance de l'approximation
% figure
% hold on
% plot(SA,Fy_discret,'+')
% plot((-13:0.01:13),polyval(coefficient,(-13:0.01:13)))