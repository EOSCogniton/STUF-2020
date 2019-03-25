function [Y] = f_pacejka(coeff, X)

% Coeff sont les coefficients de pacejka dna sla forme basique, coeff = [D, C, B, E]
% X est une liste de SA ou SL
% Y est FY, FX ou MZ

% Les valeurs usuelles pour SL sont (-0.25:0.005:0.25) et pour SA (-20:0.05:20)
if length(coeff)==4
    Y = coeff(1)*sin(coeff(2)*atan(coeff(3)*(X)-coeff(4)*(coeff(3)*(X)-atan(coeff(3).*(X)))));
elseif length(coeff)==5
    Y = coeff(1)*sin(coeff(2)*atan(coeff(3)*(X)-coeff(4)*(coeff(3)*(X)-atan(coeff(3).*(X))))) + coeff(5);
else
    Y = coeff(1)*sin(coeff(2)*atan(coeff(3)*(X-coeff(5))-coeff(4)*(coeff(3)*(X-coeff(5))-atan(coeff(3).*(X-coeff(5)))))) + coeff(6);
end

% tracé pour confirmer le resultat de la fonction

% figure
% plot(X, Y, 'r')
