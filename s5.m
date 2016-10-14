function [ s ] = s5(A_zero,beta,omega_zero,alpha,phi,t)
% phi(t) = (A_zero+beta*t) * sin(2*pi*t*(omega_zero+alpha*t)+phi);
s =  (A_zero+beta*t) * sin(2*pi*t*(omega_zero+alpha*t)+phi);
end

