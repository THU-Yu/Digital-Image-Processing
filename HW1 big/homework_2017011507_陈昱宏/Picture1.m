I = im2double(imread('.\Data\3.bmp'));
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
mask(mag < 78 & mag > 19 & freq < 8 & freq > 0) = 1;
% ��̬ѧ����
mask = bwmorph(mask,'open');
mask = bwmorph(mask,'close');
mask = bwmorph(mask,'close');
se=strel('disk', 5);
mask=imopen(mask, se);
se=strel('disk', 15);
mask=imclose(mask, se);
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
imwrite(NewI, ".\Data\3_with_mask.bmp");
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
imwrite(orientimage, ".\Data\3_orientimage.bmp");
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
            % �����ݲ�ͨ���˲�������������ȡ
            [DX, DY] = meshgrid(1:32);
            D0 = 20;
            n = 2;
            I1 = I(i*8-7:min(i*8 + 24, end),j*8-7:min(j*8 + 24,end));
            dft = fftshift(fft2(I1,32,32));
            dft(17,17) = 0;
            [maxi, maxj] = MaxPoint(dft);
            % �����ݲ�ͨ���˲���
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
title("ƽ����ķ���ͼ");
imwrite(orientimage, ".\Data\3_orientimage_smoothing.bmp");
subplot(2,3,5);imshow(filterimage);
title("���˲����ͼ");
imwrite(filterimage, ".\Data\3_filterimage.bmp");
%%
% �������ص���������
filterimage = imadjust(filterimage, [0, max(max(filterimage))], [0,1],1);
% �ٽ������ȵ���
newfilterimage = filterimage;
newfilterimage(filterimage > 0.15) = 1;
subplot(2,3,6);imshow(newfilterimage);
title("������ǿͼ");
imwrite(newfilterimage, ".\Data\3_filterimage_final.bmp");