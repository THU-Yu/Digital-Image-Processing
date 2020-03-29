function NewI = colorgrad(I)
if (ndims(I)~=3) || (size(I,3)~=3)
    error('Input image must be RGB');
end
sx = fspecial('sobel');
sy = sx';
Rx = imfilter(double(I(:,:,1)), sx, 'replicate');
Ry = imfilter(double(I(:,:,1)), sy, 'replicate');
Gx = imfilter(double(I(:,:,2)), sx, 'replicate');
Gy = imfilter(double(I(:,:,2)), sy, 'replicate');
Bx = imfilter(double(I(:,:,3)), sx, 'replicate');
By = imfilter(double(I(:,:,3)), sy, 'replicate');

RG = sqrt(Rx.^2 + Ry.^2);
GG = sqrt(Gx.^2 + Gy.^2);
BG = sqrt(Bx.^2 + By.^2);

NewI = mat2gray(RG + GG + BG);