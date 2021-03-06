function [ sampledSignal ] = sampling( originalSignal, N )
%sample : this function do the sampling process of a signal
    sampledSignal = (1:1:N);
    delta = uint64(numel(originalSignal)/N);
    for i=1:1:N,
        sampledSignal(i) = sampleInterval(originalSignal(min((i-1)*delta+1,numel(originalSignal)):min(i*delta,numel(originalSignal))));
    end 
    if N>size(originalSignal)
        sampledSignal = decompress_1d(originalSignal,N);
    end
end

