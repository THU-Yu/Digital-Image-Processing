function image = DFT2D(I)
    [X, Y] = meshgrid(1:256);
    [m, n] = size(I);
    I = I .* ((-1) .^ (X + Y));
    a = (0:m-1)'*(0:m-1);
    dftMartix = exp(-2*pi*1i*a/m);
    image = dftMartix * I;
    a = (0:n-1)'*(0:n-1);
    dftMartix = exp(-2*pi*1i*a/n);
    image = image * dftMartix;
end