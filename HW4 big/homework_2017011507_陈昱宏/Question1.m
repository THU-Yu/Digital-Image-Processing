close all
clear all
% ѡ����Ҫ�ķ�����ͻ����������������ַ��
% ��Ӧ���ļ���Ϊ��OilPainting.jpg(�ͻ�)��Comic.jpg(����)��Sketch.jpg(����)��Sketch250.jpg��������Ի�һЩ�����裩
src_img = imread('.\data\OilPainting.jpg');
imshow(src_img);
% ѡ�����Ϻ����������㣬�и���µľ���
[xs1,ys1] = ginput(2);
src_img = src_img(floor(ys1(1)):floor(ys1(2)),floor(xs1(1)):floor(xs1(2)),1:3);
[h1,w1,c] = size(src_img);
xs1 = [1 w1 1 w1]';
ys1 = [1 1 h1 h1]';
%%
% ѡ����Ҫ��Ŀ��ͼ��
target_img = imread('.\data\targetImage4.jpg');
[h2,w2,c] = size(target_img);
imshow(target_img);
% �ĸ����ȡ���ֱ������ϡ����ϡ����¡�����
[xs2,ys2] = ginput(4);
%%
% ���´���ο���ʦ�ĵ�ʮ���´���ʾ����ѡ��projectiveģʽ�ı任
tform = fitgeotrans([xs1 ys1],[xs2 ys2],'projective');
src_registered = imwarp(src_img,tform,'OutputView',imref2d(size(target_img)));
mask = sum(src_registered,3)~=0;
% ����Ԥ�ȷָ��ǰ����mask
BW = imread('.\data\targetimagemask4.jpg');
BW = im2bw(BW,0.5);
% ������mask�����������������Ҫ�任��λ��
mask = mask & BW;
idx = find(mask);
% ��Ŀ��ͼ����б任
target_img(idx) = src_registered(idx);
target_img(idx+h2*w2) = src_registered(idx+h2*w2);
target_img(idx+2*h2*w2) = src_registered(idx+2*h2*w2);
imshow(target_img);