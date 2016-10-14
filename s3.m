function [ s ] = s3( A,omega_zero,alpha,phi,t)
% phi(t) = A * sin(2*pi*t*(omega_zero+alpha*t)+phi)
s =  A * sin(2*pi*t*(omega_zero+alpha*t)+phi);
end

