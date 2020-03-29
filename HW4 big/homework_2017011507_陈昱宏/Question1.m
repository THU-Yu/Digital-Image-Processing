close all
clear all
% 选择想要的风格，有油画、动漫和素描三种风格
% 对应的文件名为：OilPainting.jpg(油画)、Comic.jpg(动漫)、Sketch.jpg(素描)、Sketch250.jpg（背景相对黄一些的素描）
src_img = imread('.\data\OilPainting.jpg');
imshow(src_img);
% 选择左上和右下两个点，切割成新的矩形
[xs1,ys1] = ginput(2);
src_img = src_img(floor(ys1(1)):floor(ys1(2)),floor(xs1(1)):floor(xs1(2)),1:3);
[h1,w1,c] = size(src_img);
xs1 = [1 w1 1 w1]';
ys1 = [1 1 h1 h1]';
%%
% 选择想要的目标图像
target_img = imread('.\data\targetImage4.jpg');
[h2,w2,c] = size(target_img);
imshow(target_img);
% 四个点的取法分别是左上、右上、左下、右下
[xs2,ys2] = ginput(4);
%%
% 以下代码参考老师的第十三章代码示例，选择projective模式的变换
tform = fitgeotrans([xs1 ys1],[xs2 ys2],'projective');
src_registered = imwarp(src_img,tform,'OutputView',imref2d(size(target_img)));
mask = sum(src_registered,3)~=0;
% 读入预先分割的前背景mask
BW = imread('.\data\targetimagemask4.jpg');
BW = im2bw(BW,0.5);
% 将两个mask进行与操作，保留想要变换的位置
mask = mask & BW;
idx = find(mask);
% 对目标图像进行变换
target_img(idx) = src_registered(idx);
target_img(idx+h2*w2) = src_registered(idx+h2*w2);
target_img(idx+2*h2*w2) = src_registered(idx+2*h2*w2);
imshow(target_img);