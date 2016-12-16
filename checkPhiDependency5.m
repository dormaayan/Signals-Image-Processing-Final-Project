% Validate whether there is any dependency of the bit allocation problem
% with the phi in function 5 when omega is integer and when not
for i=1:1:10,
 A = rand * 15;
 B = 12379;
 alpha = rand*5;
 beta = rand*3;
 omega = rand * 10;
 floor_omega = floor(omega);
 phi = rand*2*pi;
 [b_org,N_org,] = func5Numerically(omega,phi,A,alpha,beta,B);
 [b_org_floor,N_org_floor,] = func5Numerically(floor_omega,phi,A,floor(alpha),beta,B);
 for j=1:1:10,
    phi = rand*2*pi;
    b = func5Numerically(omega,phi,j,alpha,beta,B);
    if abs(b-b_org)>0.001
        disp('General Dependent !!!');
    end 
    if abs(b-b_org)>0.1
        disp('Significant General Dependent !!!');
    end 
    b_floor = func5Numerically(floor(omega),phi,j,floor(alpha),beta,B);
    if abs(b_floor-b_org_floor)>0.001
        disp('Integer Dependent !!!');
    end 
    if abs(b_floor-b_org_floor)>0.1
        disp('Significant Integer Dependent !!!');
    end 
 end
 fprintf('done: %d \n',i);
end
