% Validate whether there is any dependency of the bit allocation problem
% with the phi in function 4 when omega is integer and when not
for i=1:1:10,
    epsilon = 0.001;
    A = rand * 15 + epsilon;
    B = 2048;
    alpha = rand*5 + epsilon;
    omega = rand * 10 + epsilon;
    floor_omega = floor(omega);
    [b_org,N_org,] = func4Numerically(omega,phi,A,alpha,B);
    [b_org_floor,N_org_floor,] = func4Numerically(floor_omega,phi,A,floor(alpha),B);
    for j=1:1:10,
        phi = rand*2*pi;
        b = func4Numerically(omega,phi,j,alpha,B);
        b_floor = func4Numerically(floor(omega),phi,j,floor(alpha),B);
        if abs(b_floor-b_org_floor)>0.1
            disp('Significant Integer Dependent !!!');
            break;
        end
        if abs(b_floor-b_org_floor)>epsilon
            disp('Integer Dependent !!!');
            break;
        end
        if abs(b-b_org)>0.1
            disp('Significant General Dependent !!!');
            break;
        end
        if abs(b-b_org)>epsilon
            disp('General Dependent !!!');
            break;
        end
    end
    fprintf('done: %d \n',i);
end

