function NewI = OilPainting(I,k)
    I_gray = rgb2gray(I);
    [m,n] = size(I_gray);
    I = im2double(rgb2lab(I));
    [L,N] =  MySLIC(I,I_gray,k,10,0);
    NewI = I;
    for i = 1:N
        index = find(L == i);
        [h,w] = ind2sub([m,n],index);
        Sizei = size(index);
        pixels = [0,0,0];
        for j = 1:Sizei(1)
            pixels = pixels + [I(h(j),w(j),1), I(h(j),w(j),2), I(h(j),w(j),3)];
        end
        pixels = pixels / Sizei(1);
        for j = 1:Sizei(1)
            NewI(h(j),w(j),:) = pixels;
        end
    end
