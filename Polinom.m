% Check our mathematical part with simple and intresting polinom
function [] = Polinom(bitBudget)
t = 0:0.00001:1;
s = (1/16)*(231*t.^6-315*t.^4+105*t.^2-5);
[bNumerical,NNumerical] = polinomNumerically(bitBudget);
qss = sampleAndQuantize(s,bitBudget,1);
mse = mseProject(s,qss);
min_b = 1;
for b=2:1:16,
    tempQss = sampleAndQuantize(s,floor(bitBudget/b),b);
    tempMse = mseProject(s,tempQss);
    if tempMse<mse,
        qss = tempQss;
        mse = tempMse;
        min_b = b;
    end
end
qss = decompress_1d(qss,numel(t));
figure;
plot(t,s);
figure;
plot(t,qss);
fprintf('Exhausted Serch Optimal b : %d \n',min_b);
fprintf('Exhausted Serch Optimal N : %d \n',floor(bitBudget/min_b));
fprintf('Numerical Optimal b : %d \n',bNumerical);
fprintf('Numerical Optimal N : %d \n',NNumerical);
end
