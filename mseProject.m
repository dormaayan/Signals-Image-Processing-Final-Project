function [mse_error] = mseProject(A,B)
%Calculate the mse error of the matrix

difference = double(A)- double(decompress_1d(B,numel(A)));
squared_difference=difference.^2;
[hight,width]=size(A);
mse_error = sum(squared_difference(:))/(hight*width);
end

