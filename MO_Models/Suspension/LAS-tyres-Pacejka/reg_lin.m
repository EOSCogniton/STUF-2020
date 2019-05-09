function [a, b] = reg_lin(x,y)

C = transpose([x; ones(1,length(x))]);
d = transpose(y);

A = zeros(2,2);
b = zeros(2,1);

coeff = lsqlin(C,d,A,b); 

a = coeff(1);
b = coeff(2);