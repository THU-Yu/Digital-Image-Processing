I = imread('Data\1.jpg');
I = rgb2gray(I);
I1 = I(502:539, 1456:1504);
imwrite(I1, 'Data\1_Gauss.jpg');
I2 = fftshift(fft2(im2double(I1)));
imagesc(log(abs(I2)));
I3 = I(589:673, 248:322);
imwrite(I3, 'Data\1_Sin.jpg');
I4 = fftshift(fft2(im2double(I3)));
imagesc(log(abs(I4)));
I5 = I(610:620, 16:34);
imwrite(I5, 'Data\1_Inpluse.jpg');
I6 = fftshift(fft2(im2double(I5)));
imagesc(log(abs(I6)));
I7 = I(946:970, 983:1003);
imwrite(I7, 'Data\1_Rect.jpg');
I8 = fftshift(fft2(im2double(I7)));
imagesc(log(abs(I8)));