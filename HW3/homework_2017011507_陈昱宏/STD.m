function std_local_my = STD(I, I2, d)
    IntegralI = zeros(size(I) + [floor((d-1)/2)+floor((d)/2) floor((d-1)/2)+floor((d)/2)]);
    IntegralI(floor((d-1)/2)+1:end-floor((d)/2), floor((d-1)/2)+1:end-floor((d)/2)) = I;
    IntegralI = integralImage(IntegralI);
    IntegralI2 = zeros(size(I2) + [floor((d-1)/2)+floor((d)/2) floor((d-1)/2)+floor((d)/2)]);
    IntegralI2(floor((d-1)/2)+1:end-floor((d)/2), floor((d-1)/2)+1:end-floor((d)/2)) = I2;
    IntegralI2 = integralImage(IntegralI2);
    [m,n] = size(I);
    std_local_my = zeros(size(I2));
    for i = 1:m
        for j = 1:n
            i1 = i + floor((d-1)/2)+1;
            j1 = j + floor((d-1)/2)+1;
            sum1 = IntegralI(i1+floor((d)/2), j1+floor((d)/2)) + IntegralI(i1-floor((d-1)/2)-1, j1-floor((d-1)/2)-1) - IntegralI(i1+floor((d)/2), j1-floor((d-1)/2)-1) - IntegralI(i1-floor((d-1)/2)-1, j1+floor((d)/2));
            sum2 = IntegralI2(i1+floor((d)/2), j1+floor((d)/2)) + IntegralI2(i1-floor((d-1)/2)-1, j1-floor((d-1)/2)-1) - IntegralI2(i1+floor((d)/2), j1-floor((d-1)/2)-1) - IntegralI2(i1-floor((d-1)/2)-1, j1+floor((d)/2));
            std_local_my(i, j) = sqrt((sum2 - sum1^2/(d*d)) / (d*d-1));
        end
    end
end