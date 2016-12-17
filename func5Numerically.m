% Numerical calculation of N,b and the mse of function 5
function [b,N,mse] = func5Numerically( omega,phi,A,alpha,beta,B)
    syms symb;
    fun = @(t) (2.*pi.*(beta.*t+A).*(omega+2.*alpha.*t).*cos(2.*pi.*t.*(omega+alpha.*t)+phi)+beta.*sin(2.*pi.*t.*(omega+alpha.*t)+phi)).^2;
    Energy = integral(fun,0,1);
    range = 2*(beta+A);
    b = double(solve(Energy/(6*B^2)*symb-log(2)*range^2/(6*2^(2*symb)),symb));
    N = B/b;
    mse = Energy/(12*N^2)+range^2/(12*2^(2*b));
end

