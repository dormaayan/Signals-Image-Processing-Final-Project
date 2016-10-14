function [ s ] = s2( A,omega,phi,t)
% phi(t) = A * cos(2*pi*omega*t+phi)
s =  A * cos(2*pi*omega*t+phi);
end

