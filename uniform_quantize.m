function [qs,D,R] = uniform_quantize(s,b)
%QUANTIZE
%Calculate the resolution
J=2^b;
mx = max(max(s));
mn = min(min(s));
if mx==mn,
    qs=s;
else
    %Create the desicion levels
    D = [mn:((mx-mn)/J):mx];
    %Create the representation levels
    R = D + ((mx-mn)/(2*J));
    R = R(1:J);
    %Do the quantization itself
    [qs]=quantize(s,D,R,J);
end
end

