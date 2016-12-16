% Validate our assumption in the theoretical part
% that functions 1 and 2 are the same when omega is integer
for i=1:1:10,
 B = 12379;
 A = rand * 100;
 phi = rand*2*pi;
 omega = rand * 100;
 omega_floor = floor(omega);
 if abs(func1Numerically(omega_floor,phi,A,B)- func2Numerically(omega_floor,phi,A,B))>0.001
     disp('false !');
 end 
 if abs(func1Numerically(omega,phi,A,B)- func2Numerically(omega,phi,A,B))>0.001
     disp('correct !');
 end 
fprintf('Done : %d \n',i);
end

