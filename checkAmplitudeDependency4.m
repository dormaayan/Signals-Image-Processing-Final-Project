% Validate whether there is any dependency of the bit allocation problem
% with the amplitude in function 4
for i=1:1:10,
 B = 1024;
 omega = rand * 10;
 phi = rand*2*pi;
 alpha = rand * 10;
 [b_org,N_org,] = func4Numerically( omega,phi,1,alpha,B);
 for j=10:10:100,
    [b,N,] = func4Numerically( omega,phi,j,alpha,B);
    if abs(b-b_org)>0.001
        disp('Dependent !!!');
    end 
 end
 fprintf('done: %d \n',i);
end

