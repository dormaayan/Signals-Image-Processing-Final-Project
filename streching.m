function [ ret_image ] = decompress_1d(image, new_size)
    [r,c] = size(image);
    ratio_r = new_size/r;
    ratio_c = new_size/c;
   
    for i=1:1:new_size,
        for j=1:1:new_size,
            new_i = idivide(int32(i-1),ratio_r,'floor');
            new_j = idivide(int32(j-1),ratio_c,'floor');
            ret_image(i,j)=image(new_i+1,new_j+1);
        end 
    end
end