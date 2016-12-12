% calculate the average of valuse in a specific interval
% auxilary function for the sampling process
function [ sample ] = sampleInterval( interval )
    sample = sum(sum(interval))/numel(interval);
end

