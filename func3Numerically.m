function [b,N,mse] = func3Numerically( omega,phi,A,alpha,B)
    syms symb;
    fun = @(t) (2.*pi.*A.*(omega+2.*alpha.*t).*cos(2.*pi.*t.*(omega+alpha.*t)+phi)).^2;
    Energy = integral(fun,0,1);
    range = 2*A;
    b = double(solve(Energy/(6*B^2)*symb-log(2)*range^2/(6*2^(2*symb)),symb));
    N = B/b;
    mse = Energy/(12*N^2)+range^2/(12*2^(2*b));
end

