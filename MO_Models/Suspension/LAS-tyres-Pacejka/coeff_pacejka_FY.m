function [coeff] = coeff_pacejka_FY(carrossage,charge,pression,round)

%attention, cette fonction ne marche que pour les pneu Hoosier de 13 pouces
%avec les jante Oz d'une largeur de 7"
%(ceux choisis par l'écurie)

% Cette fonction renvoie les coefficients de Pacejka dans sa forme la plus
% simple, il faut ensuite utiliser la fonction de Pacejka pour avoir la
% courbe FY = f(SA)

%paramètres du pneu
r=int2str(round);  % 5 ou 6 pour l'instant
IA=int2str(carrossage); %Doit être un entier compris dans la liste suivante : [0 1 2 3 4] 
Fz=int2str(charge);  %Doit être un entier compris dans la liste suivante : [50 100 150 250 350]
P=pression;  %doit être un STRING compris dans la liste suivante : ['8','10','12i', '12f', '14']

%chargement du fichier
file = strcat('Round',r,'_Corner_all_run.mat');
load(file);   %permet d'importer la grande matrice dans le workplace
fichier=strcat('C',r,'_HB137_',P,'_25_',Fz,'_',IA);   %nom du pneu
fichier=eval(fichier);       %permet d'accéder à la variable ayant comme nom 'fichier' , si on fait pas ça ça ne marche pas
FY_discret=fichier.FY;      %On accède à MZ
SA=fichier.SA;

%fonction de pacejka la plus simple
FY_pacejka = @(a, SA) a(1)*sin(a(2)*atan(a(3)*(SA-a(5))-a(4)*(a(3)*(SA-a(5))-atan(a(3).*(SA-a(5)))))) + a(6);
%a = [D, C, B, E, Sh, SV]

%condition initiale

%voir le document PCVpneu
Sv = mean(FY_discret);
a0 = [0, 0, 0, 0, 0];

FYmax = max(FY_discret);
SAzero = [];
SAmax = [];
for i=1:length(FY_discret)
    if abs(FY_discret(i)- Sv)<FYmax*0.05 && abs(SA(i))<4
        SAzero = [SAzero SA(i)];
    end
    if FY_discret(i)> 0.90*FYmax
        SAmax = [SAmax SA(i)];
    end
end
Sh = mean(SAzero);
xm = mean(SAmax);

%Regression linéaire pour avoir la dérivée à l'origine
borne_inf = Sh-1;
borne_sup = Sh+1;
x = [];
y = [];
for i=1:length(FY_discret)
    if SA(i)>borne_inf && SA(i)<borne_sup
        x = [x SA(i)];
        y = [y FY_discret(i)];
    end
end
[a, b] = reg_lin(x,y);

a0(1) = FYmax;
a0(2) = 1.3;
a0(3) = a / (a0(2)*a0(1)); 
a0(4) = (a0(3)*xm-tan(pi/(2*a0(2))))/(a0(3)*xm-atan(a0(3)*xm*pi/180));
a0(5) = Sh;
a0(6) = Sv;

%optimisation

FYtest = @(a) FY_pacejka(a, SA) - FY_discret;

for i=1:2
    coeff = lsqnonlin(FYtest, a0);
    a0 = coeff;
end

%tracé pour confirmer le resultat de la fonction

% figure
% plot(SA, FY_discret, 'o')
% hold on
% SAtest = -12:0.05:12;
% plot(SAtest, FY_pacejka(coeff, SAtest), 'r')
