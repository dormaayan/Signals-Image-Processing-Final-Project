function [ sample ] = sampleInterval( interval )
    sample = sum(sum(interval))/numel(interval);
end

