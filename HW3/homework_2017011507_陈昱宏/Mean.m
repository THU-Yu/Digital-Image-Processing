function mean_local_my = Mean(I, d)
    [m,n] = size(I);
    IntegralI = zeros([m+floor((d-1)/2)+floor((d)/2),n+floor((d-1)/2)+floor((d)/2)]);
    IntegralI(floor((d-1)/2)+1:end-floor((d)/2), floor((d-1)/2)+1:end-floor((d)/2)) = I;
    IntegralI = integralImage(IntegralI);
    mean_local_my = zeros(size(I));
    for i = 1:m
        for j = 1:n
            i1 = i + floor((d-1)/2)+1;
            j1 = j + floor((d-1)/2)+1;
            sum = IntegralI(i1+floor((d)/2), j1+floor((d)/2)) + IntegralI(i1-floor((d-1)/2)-1, j1-floor((d-1)/2)-1) - IntegralI(i1+floor((d)/2), j1-floor((d-1)/2)-1) - IntegralI(i1-floor((d-1)/2)-1, j1+floor((d)/2));
            mean_local_my(i, j) = sum / (d*d);
        end
    end
end
