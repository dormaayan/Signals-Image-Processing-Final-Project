% t_grid = 0:0.00001:1;
% s = s1(10,1,0,t_grid);
% x = 200;
% ss =sampling(s,x);
% figure;
% plot(t_grid,s);
% figure;
% plot(0:(1/(x-1)):1,ss);
% qss = uniform_quantize(ss,8);
% figure;
% plot(0:(1/(x-1)):1,qss);
% 
% t_grid = 0:0.00001:1;
% s = s1(10,1,0,t_grid);
% N = 200;
% figure;
% plot(t_grid,s);
% figure;
% plot(0:(1/(N-1)):1,sampleAndQuantize(s,N,8));

disp(decompress_1d([1 2 3 4],9));
