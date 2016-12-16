% Validate whether there is any dependency of the bit allocation problem
% with the amplitude in function 1
for i=1:1:10,
 B = 12379;
 omega = rand * 10;
 phi = rand*2*pi;
 alpha = rand * 10;
 [b_org,N_org,] = func3Numerically( omega,phi,1,alpha,B);
 for j=10:10:100,
    [b,N,] = func3Numerically( omega,phi,j,alpha,B);
    if abs(b-b_org)>0.001
        disp('Dependent !!!');
    end 
 end
 fprintf('done: %d \n',i);
end

