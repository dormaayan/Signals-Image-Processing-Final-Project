function [ sampledSignal ] = sampling( originalSignal, N )
%sample : this function do the sampling process of a signal
    sampledSignal = (1:1:N);
    delta = uint64(numel(originalSignal)/N);
    for i=1:1:N,
        sampledSignal(i) = sampleInterval(originalSignal((i-1)*delta+1:min(i*delta,numel(originalSignal))));
    end 
end
