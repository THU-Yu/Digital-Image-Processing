%% 
% Read Image

close all
I = imread('.\data\0.jpg');
I = im2double(I);
I = imresize(I, [400, 600], 'bicubic');
I = im2uint8(I);
%% 
% Find the Center Position

y = (83 + 150) / 2;
x = (151 + 238) / 2;
[m, n] = size(I);
Smoothing(I, x, y, 85, '1');
x = (164 + 225) / 2;
y = (222 + 269) / 2;
Smoothing(I, x, y, 75, '2');
x = (160 + 221) / 2;
y = (329 + 378) / 2;
Smoothing(I, x, y, 70, '3');
x = (164 + 225) / 2;
y = (410 + 455) / 2;
Smoothing(I, x, y, 70, '4');
x = (167 + 217) / 2;
y = (494 + 536) / 2;
Smoothing(I, x, y, 60, '5');