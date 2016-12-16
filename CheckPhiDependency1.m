% Validate whether there is any dependency of the bit allocation problem
% with the phi in function 1 when omega is integer and when not
for i=1:1:10,
 A = rand * 15;
 B = 12379;
 omega = rand * 10;
 floor_omega = floor(omega);
 phi = rand*2*pi;
 [b_org,N_org,] = func1Numerically(omega,phi,A,B);
 [b_org_floor,N_org_floor,] = func1Numerically(floor_omega,phi,A,B);
 for j=1:1:10,
    phi = rand*2*pi;
    b = func1Numerically( omega,phi,j,B);
    if abs(b-b_org)>0.001
        disp('General Dependent !!!');
    end 
    if abs(b-b_org)>0.1
        disp('Significant General Dependent !!!');
    end 
    b_floor = func1Numerically(floor(omega),phi,j,B);
    if abs(b_floor-b_org_floor)>0.001
        disp('Integer Dependent !!!');
    end 
 end
 fprintf('done: %d \n',i);
end
