I = im2double(imread('.\Data\3.bmp'));
subplot(2,3,1);imshow(I);
title("原图");
%%
% 计算特征频率图、最大幅度图和方向图（分成Cos图和Sin图）
[W, H] = size(I);
% 由于8*8实在太小，造成特征不够突出
% 因此取其邻域32*32来当作特征
% 虽然变成32*32，但主要还是以左上的8*8为特征图
% 因此新高宽如下的M和N
M = floor(W/8) - 3;
N = floor(H/8) - 3;
% 矩阵初始化
freq = zeros(M,N); %频率图
mag = zeros(M,N); % 最大幅度图
angs = zeros(M, N); % 角度图
Sin = zeros(M, N); % Sin图
Cos = zeros(M, N); % Cos图
for i = 1:M
    for j = 1:N
        I1 = I(i*8-7:min(i*8 + 24, end),j*8-7:min(j*8 + 24,end));
        dft = fftshift(fft2(I1,32,32));
        dft = abs(dft);
        dft(17,17) = 0;%去除直流分量
        [maxi, maxj] = MaxPoint(dft);
        freq(i, j) = sqrt((maxi - 17)^2 + (maxj - 17)^2);
        mag(i, j) = dft(maxi, maxj);
        % 将角度图分成Cos图和Sin图
        angs(i, j) = atan((maxj-17)/(maxi-17));
        Sin(i, j) = sin(angs(i, j) * 2);
        Cos(i, j) = cos(angs(i, j) * 2);
    end
end
%%
mask = zeros(size(freq));
% 经过调参取得的参数
mask(mag < 78 & mag > 19 & freq < 8 & freq > 0) = 1;
% 形态学处理
mask = bwmorph(mask,'open');
mask = bwmorph(mask,'close');
mask = bwmorph(mask,'close');
se=strel('disk', 5);
mask=imopen(mask, se);
se=strel('disk', 15);
mask=imclose(mask, se);
%%
% 抠出指纹区
newmask = zeros(size(I));
[W, H] = size(I);
for i = 1:W
    for j = 1:H
        x = ceil(i / 8);
        y = ceil(j / 8);
        if mask(min(x,M),min(y,N)) == 1
            newmask(i, j) = 1;
        end
    end
end
NewI = I .* newmask;
subplot(2,3,2);imshow(NewI);
title("仅有指纹区");
imwrite(NewI, ".\Data\3_with_mask.bmp");
%%
orientimage = zeros(8*M,8*N); % 方向图初始化
for i = 1:M
    for j = 1:N
        if mask(i,j) == 1
            % 绘制初始方向图
            line = zeros(8,8);
            line(4:5,:) = 1;
            line = imrotate(line, angs(i,j) * 180 / pi, 'bicubic', 'crop');
            orientimage(8*i-7:8*i, 8*j-7:8*j) = line;
        end
    end
end
subplot(2,3,3);imshow(orientimage);
title("没有平滑的方向图");
imwrite(orientimage, ".\Data\3_orientimage.bmp");
%%
% 对Sin图、Cos图和频率图做空域平滑
h = ones(3,3) ./ 9;
Sin = imfilter(Sin, h);
Cos = imfilter(Cos, h);
freq = imfilter(freq, h);
angs = atan2(Sin, Cos) / 2;
filterimage = zeros(size(I)); % 新图像初始化
H = ones(32,32);
for i = 1:M
    for j = 1:N
        if mask(i,j) == 1
            % 绘制平滑后方向图
            line = zeros(8,8);
            line(4:5,:) = 1;
            line = imrotate(line, angs(i,j) * 180 / pi, 'bicubic', 'crop');
            orientimage(8*i-7:8*i, 8*j-7:8*j) = line;
            % 利用陷波通过滤波器进行特征提取
            [DX, DY] = meshgrid(1:32);
            D0 = 20;
            n = 2;
            I1 = I(i*8-7:min(i*8 + 24, end),j*8-7:min(j*8 + 24,end));
            dft = fftshift(fft2(I1,32,32));
            dft(17,17) = 0;
            [maxi, maxj] = MaxPoint(dft);
            % 制作陷波通过滤波器
            Dk1 = sqrt((DX-maxi).^2+(DY-maxj).^2);
            Dk2 = sqrt((DX-32-2+maxi).^2+(DY-32-2+maxj).^2);
            H1 = 1./(1+(D0./Dk1).^(2*n));
            H2 = 1./(1+(D0./Dk2).^(2*n));
            H = H.*H1.*H2;
            H = 1 - H;
            dft = dft .* H;
            filterimage(i*8-7:min(i*8 + 24, end),j*8-7:min(j*8 + 24,end)) = real(ifft2(ifftshift(dft)));
        end
    end
end
subplot(2,3,4);imshow(orientimage);
title("平滑后的方向图");
imwrite(orientimage, ".\Data\3_orientimage_smoothing.bmp");
subplot(2,3,5);imshow(filterimage);
title("刚滤波完的图");
imwrite(filterimage, ".\Data\3_filterimage.bmp");
%%
% 先做像素的线性拉伸
filterimage = imadjust(filterimage, [0, max(max(filterimage))], [0,1],1);
% 再进行亮度调整
newfilterimage = filterimage;
newfilterimage(filterimage > 0.15) = 1;
subplot(2,3,6);imshow(newfilterimage);
title("亮度增强图");
imwrite(newfilterimage, ".\Data\3_filterimage_final.bmp");