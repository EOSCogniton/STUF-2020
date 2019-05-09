clear all; close all; clc
%% fonctions
MZ_pacejka = @(a, SA) a(1)*sin(a(2)*atan(a(3)*(SA-a(5))-a(4)*(a(3)*(SA-a(5))-atan(a(3).*(SA-a(5)))))) + a(6);

%% parameters
camber = [0 1 2 3 4];
charge = [50 100 150 250 350];
pression = '10';
round = 5;
color = ['r', 'b'];

%% plots
figure
title(strcat('round ',int2str(round),'pressure :',pression));
hold on
for i = 1:5
    for j=1:5
coeff = coeff_pacejka_MZ(camber(j),charge(i),pression,round);

SAtest = -12:0.05:12; % a verifier 
plot(SAtest, MZ_pacejka(coeff, SAtest),'b')
charge_label = strcat(int2str(charge));
text(SAtest(end), MZ_pacejka(coeff, SAtest(end)), charge_label);
camber_label = strcat(int2str(camber));
text(SAtest(1), MZ_pacejka(coeff, SAtest(1)), camber_label);
    end
end 
