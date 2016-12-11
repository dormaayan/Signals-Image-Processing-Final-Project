for i=1:1:10,
 B = 1024;
 omega = rand * 10;
 phi = rand*2*pi;
 alpha = rand * 10;
 beta = rand * 10;
 [b_org,N_org,] = func5Numerically( omega,phi,1,alpha,beta,B);
 for j=10:10:100,
    [b,N,] = func5Numerically( omega,phi,j,alpha,beta,B);
    if abs(b-b_org)>0.001
        disp('Dependent !!!');
    end 
 end
 fprintf('done: %d \n',i);
end

