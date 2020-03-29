close all;
I1 = imread('.\Data\r96_4.bmp');
figure(1);
suptitle("ԭʼͼ��");
imshow(I1);
%%
% ͼ���ֵ��
% ��ֵ���ɵ��γ��Գ�����
I1_bw = imbinarize(I1, 0.49803921565);
figure(2);
suptitle("��ֵ������");
ax(1) = subplot(2,2,1);
plot(rand(1,10), 'Parent', ax(1));
imshow(I1_bw);
title("��ֵ��");
% ������̬ѧ�Ƕ԰����ؽ��в�����������Ҫ�Զ�ֵ��ͼ��ȡ��
I1_bw = ~I1_bw;
% ���������㣬����С���Žӵĵ�ֿ�
% �ṹԪ��Ϊ2*2��������
se = strel('square',2);
I1_bw = imopen(I1_bw, se);
ax(2) = subplot(2,2,2);
plot(rand(1,10), 'Parent', ax(2));
imshow(~I1_bw);
title("��������");
% ȥ��ԭͼ�Ĺµ�
I1_bw = bwareaopen(I1_bw,100,4);
I1_bw = ~I1_bw;
ax(3) = subplot(2,2,3);
plot(rand(1,10), 'Parent', ax(3));
imshow(I1_bw);
title("ȥ���µ����");
% �ԭͼ�Ŀն�
I1_bw = bwareaopen(I1_bw,100,4);
ax(4) = subplot(2,2,4);
plot(rand(1,10), 'Parent', ax(4));
imshow(I1_bw);
title("��ն����");
linkaxes(ax,'xy');
%%
% ͼ��ϸ��
I1_bw_thin = bwmorph(~I1_bw, 'thin', inf);
figure(3);
suptitle("ϸ��ͼ����");
ax(1) = subplot(2,2,1);
plot(rand(1,10), 'Parent', ax(1));
imshow(~I1_bw_thin);
title("ϸ��ͼ��");
% ȥ��С��5�����صĶ���
I1_bw_thin = bwareaopen(I1_bw_thin,5,8);
ax(2) = subplot(2,2,2);
plot(rand(1,10), 'Parent', ax(2));
imshow(~I1_bw_thin);
title("ȥ������");
% ȥ��ë��
I1_bw_pruning = bwmorph(I1_bw_thin, 'spur',7);
ax(3) = subplot(2,2,3);
plot(rand(1,10), 'Parent', ax(3));
imshow(~I1_bw_pruning);
title("ȥ��ë��");
% ��Ȼǰ���Ѿ����Žӽ��п���������ˣ�
% Ϊ�˱���������ٽ���һ��ȥ�Žӵ�����
I1_bw_hbreak = bwmorph(I1_bw_pruning, 'hbreak');
ax(4) = subplot(2,2,4);
plot(rand(1,10), 'Parent', ax(4));
imshow(~I1_bw_hbreak);
title("ȥ���Ž�");
linkaxes(ax, 'xy');
%%
% ��������ȡ
I1_bw_final = ~I1_bw_hbreak;
feature_point = KeyPoint(I1_bw_final);
[endpoint_r, endpoint_c] = find(feature_point == 1);
[xpoint_r, xpoint_c] = find(feature_point == 3);
figure(4);
suptitle("��������ȡ���");
ax1(1) = subplot(1,2,1);
plot(rand(1,10), 'Parent', ax1(1));
imshow(I1_bw_final);
hold on;
plot(endpoint_c,endpoint_r,'s');
plot(xpoint_c,xpoint_r,'x');
hold off;
title("��ʼ��������ȡ");
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
title("��������֤��ȥ����Եα�����㣩");
linkaxes(ax1,'xy');