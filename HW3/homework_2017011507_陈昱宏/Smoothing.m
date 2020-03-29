function Newimage = Smoothing(I, x, y, r, s)
    mean_local_5 = Mean(I, 5);
    mean_local_7 = Mean(I, 7);
    mean_local_9 = Mean(I, 9);
    mean_local_11 = Mean(I, 11);
    mean_local_13 = Mean(I, 13);
    mean_local_15 = Mean(I, 15);
    [m, n] = size(I);
    for i = 1:m
        for j = 1:n
            distance = sqrt((i - x)^2 + (j - y)^2);
            if distance > r + 185
                I(i, j) = uint8(mean_local_15(i, j));
            elseif distance > r + 155
                I(i, j) = uint8(mean_local_13(i, j));
            elseif distance > r + 125
                I(i, j) = uint8(mean_local_11(i, j));
            elseif distance > r + 95
                I(i, j) = uint8(mean_local_9(i, j));
            elseif distance > r + 65
                I(i, j) = uint8(mean_local_7(i, j));
            elseif distance > r
                I(i, j) = uint8(mean_local_5(i, j));
            else
                I(i, j) = I(i, j);
            end
        end
    end
    Newimage = imresize(I, [m * 10, n * 10], 'bicubic');
    imwrite(Newimage, ".\data\my" + s + ".jpg");
end