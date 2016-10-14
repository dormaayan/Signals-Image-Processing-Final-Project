function [ ret_signal ] = decompress_1d(signal, new_size)
    r = numel(signal);
    ratio_r = new_size/r; 
    for i=1:1:new_size,
            new_i = idivide(int32(i-1),ratio_r,'floor');
            ret_signal(i)=signal(new_i+1);
     end 
end