%% 
% 2018.10, �����м䲽��

close all
I = imread('.\data\Fig0327(a)(tungsten_original).tif');
figure(1),imshow(I),set(gcf,'name','Original');
%% 
% Global histogram equalization

J1 = histeq(I);
figure(2),imshow(J1),set(gcf,'name','Global histogram equalization');
%% 
% Enhancement using local histogram statistics

I = double(I);
I2 = I .^ 2;
mean_global = mean2(I);
std_global = std2(I);
d = 33;
%% 
% ��ʦ�ķ���(ƽ��ֵ)

tic
fun1 = @(x) mean2(x);
mean_local = nlfilter(I,[d d],fun1);
toc
%% 
% �ҵķ���(ƽ��ֵ)

tic
mean_local_my = Mean(I, d);
toc
max(max(abs(mean_local-mean_local_my)))
%% 
% ��ʦ�ķ���(����)

tic
fun2 = @(x) std2(x);
std_local = nlfilter(I,[d d],fun2);% slow
toc
%% 
% �ҵķ���(����)

tic
std_local_my = STD(I, I2, d);
toc
max(max(abs(std_local-std_local_my)))
%% 
% Show Image

figure(3),imshow(uint8(mean_local)),set(gcf,'name','Local mean');
figure(4),imshow(uint8(std_local)),set(gcf,'name','Local standard deviation');
%%
%��ʦ�ķ��������˵�ͼ��
k0 = 0.4; k1 = 0.02; k2 = 0.4; E = 4; % ����
mask = (mean_local<=k0*mean_global) & (std_local>=k1*std_global) & (std_local<=k2*std_global);
J2 = I;
J2(mask) = I(mask)*E;
figure(5),imshow(mask),set(gcf,'name','MASK');
figure(6),imshow(uint8(J2)),set(gcf,'name','Enhancement by local statistics');
%%
%�ҵķ��������˵�ͼ��
k0 = 0.4; k1 = 0.02; k2 = 0.4; E = 4; % ����
mask = (mean_local_my<=k0*mean_global) & (std_local_my>=k1*std_global) & (std_local_my<=k2*std_global);
J2 = I;
J2(mask) = I(mask)*E;
figure(7),imshow(mask),set(gcf,'name','MASK');
figure(8),imshow(uint8(J2)),set(gcf,'name','Enhancement by local statistics');