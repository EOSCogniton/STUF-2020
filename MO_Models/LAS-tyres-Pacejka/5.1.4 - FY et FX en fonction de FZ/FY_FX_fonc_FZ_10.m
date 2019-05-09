%Permet de tracer le max de FY et FX en fonction de la charge 
%%Initialisation

carrossage=0;
rim_diameter=7;
pression='10';
round=5;
SA_X=0; %Utile pour FX

%% FY en fonction de la charge

charge=[50 150 200 250];
FY_max=0*charge;
SA=(-13:0.05:13);
for i=1:length(charge)
    coef=coeff_approximation_Fy_10(carrossage,charge(i),rim_diameter,pression,round);
    FY=polyval(coef,SA);
    FY_max(i)=max(FY);
end

figure
plot(charge*0.453592*9.81,FY_max*0.66)
title("Force latérale maximale en fonction de la charge pour le 10'.")
xlabel('Charge verticale (N)')
ylabel('FY max (N)')

%% FX en fonction de la charge

charge=[50 150 200 250];
FX_max=0*charge;
SL=(-0.15:0.01:0.15);
for i=1:length(charge)
    coef=coeff_approximation_Fx_10(carrossage,charge(i),rim_diameter,pression,round,SA_X);
    FX=polyval(coef,SL);
    FX_max(i)=max(FX);
end

figure
plot(charge*0.453592*9.81,FX_max*0.66)
title("Force longitudinale maximale en fonction de la chargepour le 10'.")
xlabel('Charge verticale (N)')
ylabel('FX max (N)')