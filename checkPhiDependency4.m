% Validate whether there is any dependency of the bit allocation problem
% with the phi in function 4 when omega is integer and when not
for i=1:1:10,
    epsilon = 0.001;
    A = rand * 15 + epsilon;
    B = 2048;
    alpha = rand*5 + epsilon;
    omega = rand * 10 + epsilon;
    floor_omega = ceil(omega);
    phi = rand*2*pi;
    [b_org,N_org,] = func4Numerically(omega,phi,A,alpha,B);
    [b_org_floor,N_org_floor,] = func4Numerically(floor_omega,phi,A,ceil(alpha),B);
    for j=1:1:10,
        phi = rand*2*pi;
        b = func4Numerically(omega,phi,j,alpha,B);
        b_floor = func4Numerically(ceil(omega),phi,j,ceil(alpha),B);
        if abs(b_floor-b_org_floor)>0.1
            disp('Significant Integer Dependent !!!');
        end
        if abs(b_floor-b_org_floor)>epsilon
            disp('Integer Dependent !!!');
        end
        if abs(b-b_org)>0.1
            disp('Significant General Dependent !!!');
        end
        if abs(b-b_org)>epsilon
            disp('General Dependent !!!');
        end
    end
    fprintf('done: %d \n',i);
end