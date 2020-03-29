function I = TrueFeaturePoint(I)
    [h,w] = size(I);
    for i = 1:h
        for j = 1:w
            if I(i,j) == 1 || I(i,j) == 3
                if (max(I(1:i-3,j)) == 0) || (max(I(i+3:h,j)) == 0) || (max(I(i,1:j-3)) == 0) || (max(I(i,j+3:w)) == 0)
                    I(i,j) = 2;
                end
            end
        end
    end
end