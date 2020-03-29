close all;
I = imread('./data/1.jpg');
I_gray = rgb2gray(im2double(I));
I_lab = rgb2lab(I);
I = im2double(I);
[m,n] = size(I_gray);
%%
% 一般的SILC尝试不同的K和M
ks = [10 20 100 400 1600 2500];
M = [5 10 20 30 35 40];
figure(1);
for i = 1:6
    tic;
    [L,N] = MySLIC(I_lab,I_gray,ks(i),25,0);
    t = toc;
    L_bw = boundarymask(L);
    subplot(2,3,i);
    imshow(imoverlay(I,L_bw,'cyan'),'InitialMagnification',67);
    title(sprintf('k: %d, time: %.2f sec', ks(i), t));
end
figure(2);
for i = 1:6
    tic;
    [L,N] = MySLIC(I_lab,I_gray,1600,M(i),0);
    t = toc;
    L_bw = boundarymask(L);
    subplot(2,3,i);
    imshow(imoverlay(I,L_bw,'cyan'),'InitialMagnification',67);
    title(sprintf('m: %d, time: %.2f sec', M(i), t));
end
%%
% 对比原始SLIC和ASLIC（分割图）
figure(3);
tic;
[L,N] = MySLIC(I_lab,I_gray,1600,32,0);
t = toc;
L_bw = boundarymask(L);
subplot(2,2,1);
imshow(imoverlay(I,L_bw,'cyan'),'InitialMagnification',67);
title(sprintf('SLIC, time: %.2f sec', t));
tic;
[L1,N1] = MyASLIC(I_lab,I_gray,1600,32,0);
t = toc;
L1_bw = boundarymask(L1);
subplot(2,2,2);
imshow(imoverlay(I,L1_bw,'cyan'),'InitialMagnification',67);
title(sprintf('ASLIC, time: %.2f sec', t));
%%
% 显示SLIC的超像素图
I_SLIC = I;
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
        I_SLIC(h(j),w(j),:) = pixels;
    end
end
subplot(2,2,3);
imshow(I_SLIC);
title('SLIC');
%%
% 显示ASLIC的超像素图
I1_SLIC = I;
for i = 1:N1
    index = find(L1 == i);
    [h,w] = ind2sub([m,n],index);
    Sizei = size(index);
    pixels = [0,0,0];
    for j = 1:Sizei(1)
        pixels = pixels + [I(h(j),w(j),1), I(h(j),w(j),2), I(h(j),w(j),3)];
    end
    pixels = pixels / Sizei(1);
    for j = 1:Sizei(1)
        I1_SLIC(h(j),w(j),:) = pixels;
    end
end
subplot(2,2,4);
imshow(I1_SLIC);
title('ASLIC');