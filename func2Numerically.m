% Numerical calculation of N,b and the mse of function 2
function [b,N,mse] = func2Numerically( omega,phi,A,B)
    syms symb;
    Energy = 0.5*pi*omega*A^2*(4*pi*omega-sin(4*pi*omega+2*phi)+sin(2*phi));
    range = 2*A;
    b = double(solve(Energy/(6*B^2)*symb-log(2)*range^2/(6*2^(2*symb)),symb));
    N = B/b;
    mse = Energy/(12*N^2)+range^2/(12*2^(2*b));
end

