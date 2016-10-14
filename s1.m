function [ s ] = s1( A,omega,phi,t)
% phi(t) = A * sin(2*pi*omega*t+phi)
s =  A * sin(2*pi*omega*t+phi);
end

