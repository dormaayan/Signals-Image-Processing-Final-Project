function [ qss ] = sampleAndQuantize(s,N,b )
    qss = uniform_quantize(sampling(s,N),b);
end

