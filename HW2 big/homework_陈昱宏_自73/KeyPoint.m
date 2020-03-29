function I = KeyPoint(image)
    [h, w] = size(image);
    I = zeros(h,w);
    for i = 2:(h-1)
        for j = 2:(w - 1)
            if image(i,j) == 0
                P = [image(i-1,j-1), image(i-1,j), image(i-1,j+1), image(i,j+1), image(i+1,j+1), image(i+1,j), image(i+1,j-1), image(i,j-1), image(i-1,j-1)];
                Cn = 0;
                for k = 1:8
                    Cn = Cn + abs(P(k+1) - P(k));
                end
                Cn = Cn / 2;
                I(i, j) = Cn;
            end
        end
    end
end