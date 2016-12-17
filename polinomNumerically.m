% Numerical calculation of N,b and the mse of function 1
function [b,N] = polinomNumerically(B)
    syms symb;
    b = double(solve(((symb/(6*B^2))*21-log(2)/6*(4/(2^(2*symb)))),symb));
    N = B/b;
end

