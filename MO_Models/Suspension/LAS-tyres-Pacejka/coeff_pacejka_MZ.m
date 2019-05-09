function [coeff] = coeff_pacejka_MZ(carrossage,charge,pression,round)
%coeff_pacejka_MZ(camber,charge,pression,round)
%CAMBER: entier parmi [0 1 2 3 4], 1 seulement pour le round 5
%CHARGE: entier parmi [50 100 150 250 350]
%PRESSION : string parmi ['8','10','12i', '12f', '14']
%ROUND: entier parmi [5 6]

%attention, cette fonction ne marche que pour les pneu Hoosier de 13 pouces
%avec les jante Oz d'une largeur de 7"
%(ceux choisis par l'écurie)

% Cette fonction renvoie les coefficients de Pacejka dans sa forme la plus
% simple, il faut ensuite utiliser la fonction de Pacejka pour avoir la
% courbe MZ = f(SA)

%paramètres du pneu
r=int2str(round); % 5 ou 6 pour l'instant
IA=int2str(carrossage); %Doit être un entier compris dans la liste suivante : [0 1 2 3 4] 
Fz=int2str(charge);  %Doit être un entier compris dans la liste suivante : [50 100 150 250 350]
P=pression;  %doit être un STRING compris dans la liste suivante : ['8','10','12i', '12f', '14']

%chargement du fichier
% file = strcat('raw/Round',r,'_Corner_all_run.mat');
% load(file);   %permet d'importer la grande matrice dans le workplace
% fichier=strcat('C',r,'_HB137_',P,'_25_',Fz,'_',IA);   %nom du pneu
% fichier=eval(fichier);       %permet d'accéder à la variable ayant comme nom 'fichier' , si on fait pas ça ça ne marche pas
% MZ_discret=fichier.MZ;      %On accède à MZ
% SA=fichier.SA;

%suppression des valeurs de MZ pour SA>12° pour améliorer le fitting
m=1;
while m<=length(SA)
    if abs(SA(m))>12
        MZ_discret(m)=[];
        SA(m)=[];
        m=m-1;
    end
    m=m+1;
end

%fonction de pacejka la plus simple, prenant en compte le décalage
MZ_pacejka = @(a, SA) a(1)*sin(a(2)*atan(a(3)*(SA-a(5))-a(4)*(a(3)*(SA-a(5))-atan(a(3).*(SA-a(5)))))) + a(6);
%a = [D, C, B, E, Sh, SV]


%condition initiale

%voir le document PCVpneu
Sv = mean(MZ_discret);  % Décalage verticale de la courbe
a0 = [0, 0, 0, 0, 0, 0];
MZmax = max(MZ_discret);
SAzero = [];  % Liste contenant les SA tq (MZ-Sv) soit presque nul
SAmax = [];  % Liste contenant les SA tq Mz soit proche du max
for i=1:length(MZ_discret)
    if abs(MZ_discret(i)- Sv)<MZmax*0.05 && abs(SA(i))<4
        SAzero = [SAzero SA(i)];
    end
    if MZ_discret(i)> 0.90*MZmax
        SAmax = [SAmax SA(i)];
    end
end
Sh = mean(SAzero);  % Valeur de SA où MZ-Sv est nulle
xm = mean(SAmax);   % Valeur de SA où Mz est maximum

%Regression linéaire pour avoir la dérivée à l'origine, nécessaire pour
%trouver B
borne_inf = Sh-1;  % Permet d'être autour de l'origine
borne_sup = Sh+1;
% x et y sont les coordonnées des points prochent de (MZ-Sv)=0
x = [];  
y = [];
for i=1:length(MZ_discret)
    if SA(i)>borne_inf && SA(i)<borne_sup
        x = [x SA(i)];
        y = [y MZ_discret(i)];
    end
end
[a, b] = reg_lin(x,y);  % On obtient les coefficients tq ax+b=y soit la regression linéaire des points de coordonnées (x,y)

a0(1) = MZmax;
a0(2) = 2.4;
a0(3) = a / (a0(2)*a0(1));    
a0(4) = (a0(3)*xm-tan(pi/(2*a0(2))))/(a0(3)*xm-atan(a0(3)*xm*pi/180));
a0(5) = Sh;
a0(6) = Sv;

%optimisation

% Fonction que l'on cherche à minimiser
MZtest = @(a) MZ_pacejka(a, SA) - MZ_discret;  

for i=1:5
    coeff = lsqnonlin(MZtest, a0);
    a0 = coeff;
end


%%tracé pour confirmer le resultat de la fonction
% figure
% plot(SA, MZ_discret, '.')
% hold on
% SAtest = -12:0.05:12;
% plot(SAtest, MZ_pacejka(coeff, SAtest), 'r')
% title(strcat('Cornering round ',int2str(round),', load :',int2str(charge),', pressure :',pression ,', Camber :',int2str(carrossage)))

