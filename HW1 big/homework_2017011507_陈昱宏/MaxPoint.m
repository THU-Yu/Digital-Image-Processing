function [maxi, maxj] = MaxPoint(I)
    [M,N] = size(I);
    for i = 1:M
        for j = 1:N
            if (I(i,j) == max(max(I)))
            	maxi = i;
            	maxj = j;
            end
        end
    end
end