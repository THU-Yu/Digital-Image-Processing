I = im2double(imread('.\Data\77_8.bmp'));
subplot(2,3,1);imshow(I);
title("ԭͼ");
%%
% ��������Ƶ��ͼ��������ͼ�ͷ���ͼ���ֳ�Cosͼ��Sinͼ��
[W, H] = size(I);
% ����8*8ʵ��̫С�������������ͻ��
% ���ȡ������32*32����������
% ��Ȼ���32*32������Ҫ���������ϵ�8*8Ϊ����ͼ
% ����¸߿����µ�M��N
M = floor(W/8) - 3;
N = floor(H/8) - 3;
% �����ʼ��
freq = zeros(M,N); %Ƶ��ͼ
mag = zeros(M,N); % ������ͼ
angs = zeros(M, N); % �Ƕ�ͼ
Sin = zeros(M, N); % Sinͼ
Cos = zeros(M, N); % Cosͼ
for i = 1:M
    for j = 1:N
        I1 = I(i*8-7:min(i*8 + 24, end),j*8-7:min(j*8 + 24,end));
        dft = fftshift(fft2(I1,32,32));
        dft = abs(dft);
        dft(17,17) = 0;%ȥ��ֱ������
        [maxi, maxj] = MaxPoint(dft);
        freq(i, j) = sqrt((maxi - 17)^2 + (maxj - 17)^2);
        mag(i, j) = dft(maxi, maxj);
        % ���Ƕ�ͼ�ֳ�Cosͼ��Sinͼ
        angs(i, j) = atan((maxj-17)/(maxi-17));
        Sin(i, j) = sin(angs(i, j) * 2);
        Cos(i, j) = cos(angs(i, j) * 2);
    end
end
%%
mask = zeros(size(freq));
% ��������ȡ�õĲ���
mask(mag > 10 & freq < 8 & freq > 0.9) = 1;
%%
% �ٳ�ָ����
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
title("����ָ����");
imwrite(NewI, ".\Data\77_8_with_mask.bmp");
%%
orientimage = zeros(8*M,8*N); % ����ͼ��ʼ��
for i = 1:M
    for j = 1:N
        if mask(i,j) == 1
            % ���Ƴ�ʼ����ͼ
            line = zeros(8,8);
            line(4:5,:) = 1;
            line = imrotate(line, angs(i,j) * 180 / pi, 'bicubic', 'crop');
            orientimage(8*i-7:8*i, 8*j-7:8*j) = line;
        end
    end
end
subplot(2,3,3);imshow(orientimage);
title("û��ƽ���ķ���ͼ");
imwrite(orientimage, ".\Data\77_8_orientimage.bmp");
%%
% ��Sinͼ��Cosͼ��Ƶ��ͼ������ƽ��
h = ones(3,3) ./ 9;
Sin = imfilter(Sin, h);
Cos = imfilter(Cos, h);
freq = imfilter(freq, h);
angs = atan2(Sin, Cos) / 2;
filterimage = zeros(size(I)); % ��ͼ���ʼ��
H = ones(32,32);
for i = 1:M
    for j = 1:N
        if mask(i,j) == 1
            % ����ƽ������ͼ
            line = zeros(8,8);
            line(4:5,:) = 1;
            line = imrotate(line, angs(i,j) * 180 / pi, 'bicubic', 'crop');
            orientimage(8*i-7:8*i, 8*j-7:8*j) = line;
            % ����Gabor�˲�������������ȡ
            I1 = I(i*8-7:min(i*8 + 24, end),j*8-7:min(j*8 + 24,end));
            [mag, phase] = imgaborfilt(I1,10, angs(i,j) * 180 / pi - 90);
            % ȡ�м���˲������������
            filterimage(i*8-7:i*8,j*8-7:j*8) = mag(13:20, 13:20) .* cos(phase(13:20, 13:20));
        end
    end
end
subplot(2,3,4);imshow(orientimage);
title("ƽ����ķ���ͼ");
imwrite(orientimage, ".\Data\77_8_orientimage_smoothing.bmp");
subplot(2,3,5);imshow(filterimage);
title("���˲����ͼ");
imwrite(filterimage, ".\Data\77_8_filterimage.bmp");
%%
% �������ص���������
%filterimage = imadjust(filterimage, [0, max(max(filterimage))], [0,1],1);
% �ٽ������ȵ���
newfilterimage = filterimage;
newfilterimage(filterimage > 0.01) = 1;
subplot(2,3,6);imshow(newfilterimage);
title("������ǿͼ");
imwrite(newfilterimage, ".\Data\77_8_filterimage_final.bmp");