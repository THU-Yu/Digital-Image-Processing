close all;
I1 = imread('.\Data\r96_4.bmp');
figure(1);
suptitle("原始图像");
imshow(I1);
%%
% 图像二值化
% 阈值是由调参尝试出来的
I1_bw = imbinarize(I1, 0.49803921565);
figure(2);
suptitle("二值化处理");
ax(1) = subplot(2,2,1);
plot(rand(1,10), 'Parent', ax(1));
imshow(I1_bw);
title("二值化");
% 由于形态学是对白像素进行操作，所以需要对二值化图像取反
I1_bw = ~I1_bw;
% 先做开运算，将不小心桥接的点分开
% 结构元素为2*2的正方形
se = strel('square',2);
I1_bw = imopen(I1_bw, se);
ax(2) = subplot(2,2,2);
plot(rand(1,10), 'Parent', ax(2));
imshow(~I1_bw);
title("开运算结果");
% 去除原图的孤岛
I1_bw = bwareaopen(I1_bw,100,4);
I1_bw = ~I1_bw;
ax(3) = subplot(2,2,3);
plot(rand(1,10), 'Parent', ax(3));
imshow(I1_bw);
title("去除孤岛结果");
% 填补原图的空洞
I1_bw = bwareaopen(I1_bw,100,4);
ax(4) = subplot(2,2,4);
plot(rand(1,10), 'Parent', ax(4));
imshow(I1_bw);
title("填补空洞结果");
linkaxes(ax,'xy');
%%
% 图像细化
I1_bw_thin = bwmorph(~I1_bw, 'thin', inf);
figure(3);
suptitle("细化图像处理");
ax(1) = subplot(2,2,1);
plot(rand(1,10), 'Parent', ax(1));
imshow(~I1_bw_thin);
title("细化图像");
% 去除小于5个像素的短线
I1_bw_thin = bwareaopen(I1_bw_thin,5,8);
ax(2) = subplot(2,2,2);
plot(rand(1,10), 'Parent', ax(2));
imshow(~I1_bw_thin);
title("去除短线");
% 去除毛刺
I1_bw_pruning = bwmorph(I1_bw_thin, 'spur',7);
ax(3) = subplot(2,2,3);
plot(rand(1,10), 'Parent', ax(3));
imshow(~I1_bw_pruning);
title("去除毛刺");
% 虽然前面已经对桥接进行开运算避免了，
% 为了保险起见，再进行一次去桥接的运算
I1_bw_hbreak = bwmorph(I1_bw_pruning, 'hbreak');
ax(4) = subplot(2,2,4);
plot(rand(1,10), 'Parent', ax(4));
imshow(~I1_bw_hbreak);
title("去除桥接");
linkaxes(ax, 'xy');
%%
% 特征点提取
I1_bw_final = ~I1_bw_hbreak;
feature_point = KeyPoint(I1_bw_final);
[endpoint_r, endpoint_c] = find(feature_point == 1);
[xpoint_r, xpoint_c] = find(feature_point == 3);
figure(4);
suptitle("特征点提取结果");
ax1(1) = subplot(1,2,1);
plot(rand(1,10), 'Parent', ax1(1));
imshow(I1_bw_final);
hold on;
plot(endpoint_c,endpoint_r,'s');
plot(xpoint_c,xpoint_r,'x');
hold off;
title("初始特征点提取");
feature_point = TrueFeaturePoint(feature_point);
[endpoint_r, endpoint_c] = find(feature_point == 1);
[xpoint_r, xpoint_c] = find(feature_point == 3);
ax1(2) = subplot(1,2,2);
plot(rand(1,10), 'Parent', ax1(2));
imshow(I1_bw_final);
hold on;
plot(endpoint_c,endpoint_r,'s');
plot(xpoint_c,xpoint_r,'x');
hold off;
title("特征点验证（去除边缘伪特征点）");
linkaxes(ax1,'xy');