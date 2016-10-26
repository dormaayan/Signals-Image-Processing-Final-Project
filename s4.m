function [ s ] = s4(A,omega_zero,alpha,phi,t)
% phi(t) = A * sin(2*pi*t*(omega_zero+alphat^t-1)+phi)
s =  A * sin(2*pi*t.*(omega_zero+alpha.^t-1)+phi);
end

