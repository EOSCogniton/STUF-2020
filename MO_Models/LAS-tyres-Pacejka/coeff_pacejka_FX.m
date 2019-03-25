function [coeff] = coeff_pacejka_FX(carrossage,charge,pression,round,slipe_angle)

%attention, cette fonction ne marche que pour les pneu Hoosier de 13 pouces
%avec les jante Oz d'une largeur de 7" 
%(ceux choisis par l'�curie)

% Cette fonction renvoie les coefficients de Pacejka dans sa forme la plus
% simple, il faut ensuite utiliser la fonction de Pacejka pour avoir la
% courbe FX = f(SL)

%param�tres du pneu
r=int2str(round);  % 5 ou 6
IA=int2str(carrossage); %Doit �tre un entier compris dans la liste suivante : [0 2 4] 
Fz=int2str(charge);  %Doit �tre un entier compris dans la liste suivante : [50 100 150 250 350]
P=pression;  %doit �tre un STRING compris dans la liste suivante : ['8','10','12i', '12f', '14']
SA=int2str(slipe_angle); %Doit �tre un entier compris dans la liste suivante : [0 3 6]

%chargement du fichier
file = strcat('raw/Round',r,'_Brake_all_run.mat');
load(file);   %permet d'importer la grande matrice dans le workplace
fichier=strcat('B',r,'_HB137_',P,'_25_',Fz,'_',IA,'_',SA);   %nom du pneu
fichier=eval(fichier);       %permet d'acc�der � la variable ayant comme nom 'fichier' , si on fait pas �a �a ne marche pas
FX_discret=fichier.FX;      %On acc�de � FX
SL=fichier.SL;

%fonction de pacejka la plus simple
% FX_pacejka = @(a, SL) a(1)*sin(a(2)*atan(a(3)*(SL-a(5))-a(4)*(a(3)*(SL-a(5))-atan(a(3).*(SL-a(5)))))) + a(6);
% %a = [D, C, B, E, Sh, SV]
FX_pacejka = @(a, SL) a(1)*sin(a(2)*atan(a(3)*(SL)-a(4)*(a(3)*(SL)-atan(a(3).*(SL)))));

%condition initiale

%voir le document PCVpneu
%voir le document PCVpneu
Sv = mean(FX_discret);  % D�calage verticale de la courbe
%a0 = [0, 0, 0, 0, 0, 0];
a0 = [0, 0, 0, 0];
FXmax = max(FX_discret);
SLzero = [];  % Liste contenant les SA tq (MZ-Sv) soit presque nul
SLmax = [];  % Liste contenant les SA tq Mz soit proche du max
for i=1:length(FX_discret)
    if abs(FX_discret(i)- Sv)<FXmax*0.05 && abs(SL(i))<4
        SLzero = [SLzero SL(i)];
    end
    if FX_discret(i)> 0.90*FXmax
        SLmax = [SLmax SL(i)];
    end
end
Sh = mean(SLzero);  % Valeur de SA o� MZ-Sv est nulle
xm = mean(SLmax);   % Valeur de SA o� Mz est maximum

%Regression lin�aire pour avoir la d�riv�e � l'origine, n�cessaire pour
%trouver B
borne_inf = Sh-1;  % Permet d'�tre autour de l'origine
borne_sup = Sh+1;
% x et y sont les coordonn�es des points prochent de (MZ-Sv)=0
x = [];  
y = [];
for i=1:length(FX_discret)
    if SL(i)>borne_inf && SL(i)<borne_sup
        x = [x SL(i)];
        y = [y FX_discret(i)];
    end
end
[a, b] = reg_lin(x,y);  % On obtient les coefficients tq ax+b=y soit la regression lin�aire des points de coordonn�es (x,y)

a0(1) = FXmax;
a0(2) = 1.65;
a0(3) = a / (a0(2)*a0(1));    
a0(4) = (a0(3)*xm-tan(pi/(2*a0(2))))/(a0(3)*xm-atan(a0(3)*xm*pi/180));
% a0(5) = Sh;
% a0(6) = Sv;

%optimisation

FXtest = @(a) FX_pacejka(a, SL) - FX_discret;

for i=1:10
    coeff = lsqnonlin(FXtest, a0);
    a0 = coeff;
end

% trac� pour confirmer le resultat de la fonction

figure
plot(SL, FX_discret, '.')
hold on
SLtest = -0.25:0.005:0.17;
plot(SLtest, FX_pacejka(coeff, SLtest), 'r')

