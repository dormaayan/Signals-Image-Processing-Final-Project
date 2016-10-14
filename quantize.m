function [ qs ] = quantize(s,D,R,J )
qs=s;
[x,l]=size(s);
for i=1:1:l,
    for k=2:1:J+1,
        if s(i) <= D(k),
            qs(i)= R(k-1);
            break;
        end
    end
end

end

