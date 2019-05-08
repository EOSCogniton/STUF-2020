clear all; close all; clc
%% parameters
camber = [0 2 4];
charge = [50,100,150,250];
pression = '10';
round = 5;
%% plots
figure
title(strcat('HB\_13\_7\_25 FY - 10" ',' round: ',int2str(round),', ','pressure :',pression));
xlabel('SA')
ylabel('FY(N)')
hold on
for i = 1:length(charge)
    for j=1:length(camber)
        ch = charge(i); ca =camber(j);
coeff = coeff_pacejka_FY1(ca,ch,pression,round);

SAtest = -12:0.05:12; % a verifier 
plot(SAtest, f_pacejka(coeff, SAtest));
camber_label = strcat(int2str(ca));
text(SAtest(1), f_pacejka(coeff, SAtest(1)), camber_label, 'FontSize', 5);
    end
charge_label = strcat(int2str(ch));
text(SAtest(end), f_pacejka(coeff, SAtest(end)), charge_label, 'FontSize', 5);
end 

% Turn on the legend
L = legend('show');

% Make it 2-by-4 instead of 8-by-1
L.NumColumns = 3;
