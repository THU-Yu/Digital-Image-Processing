% 读取原图并分割左右眼
I = imread('./Data/eye1.jpg');
figure(1);
imshow(I);
suptitle('原图');
I_gray = rgb2gray(I);
Eye_R = I(270:700,229:695);
Eye_L = I(250:600,866:1310);
%%
% 对右眼进行二值化和边缘检测
Eye_R_bw = imbinarize(Eye_R,0.56);
mask = false(size(Eye_R_bw));
mask(130:270,:) = true;
h=fspecial('gaussian',5);
Eye_R_bw = imfilter(Eye_R_bw,h);
Eye_R_edge = edge(Eye_R_bw,'canny');
Eye_R_edge = Eye_R_edge .* mask;
figure(2);
subplot(1,2,1);imshow(Eye_R_edge);hold on;
title("右眼霍夫变换检测圆");
%%
% 检测右眼瞳孔外圆
rmin = 60;
houghspace_eye_R = Hough(Eye_R_edge,rmin,rmin+30,pi/100);
houghspace_size = size(houghspace_eye_R);
max_hough = max(max(max(houghspace_eye_R)));
index = find(houghspace_eye_R == max_hough);
[a1,b1,r1] = ind2sub(houghspace_size,index);
alpha = 0:pi/100:2*pi;
r1 = r1 + rmin;
x = a1 + r1*cos(alpha);
y = b1 + r1*sin(alpha);
plot(y,x,'-');
%%
% 检测右眼瞳孔内圆
rmin = 15;
houghspace_eye_R = Hough(Eye_R_edge,rmin,rmin+10,pi/100);
houghspace_size = size(houghspace_eye_R(a1-5:a1+5,b1-5:b1+5,:));
max_hough = max(max(max(houghspace_eye_R(a1-5:a1+5,b1-5:b1+5,:))));
index = find(houghspace_eye_R(a1-5:a1+5,b1-5:b1+5,:) == max_hough);
[a2,b2,r2] = ind2sub([10,10,houghspace_size(3)],index);
a2 = a2 + a1 - 5;
b2 = b2 + b1 - 5;
r2 = r2+rmin;
x = a2 + r2*cos(alpha);
y = b2 + r2*sin(alpha);
plot(y,x,'-');
%%
% 检测右眼上下眼睑
rmin = 170;
houghspace_eye_R = Hough(Eye_R_edge,rmin,rmin+30,pi/100);
houghspace_size = size(houghspace_eye_R);
max_hough = max(max(max(houghspace_eye_R)));
index = find(houghspace_eye_R == max_hough);
[a3,b3,r3] = ind2sub(houghspace_size,index);
r3 = r3+rmin;
x = a3 + r3*cos(alpha);
y = b3 + r3*sin(alpha);
plot(y,x,'-');
rmin = 200;
houghspace_eye_R = Hough(Eye_R_edge,rmin,rmin+10,pi/100);
max_hough = max(max(max(houghspace_eye_R(floor(houghspace_size(1)/2):end,:,:))));
index = find(houghspace_eye_R(floor(houghspace_size(1)/2):end,:,:) == max_hough);
[a4,b4,r4] = ind2sub([ceil(houghspace_size(1)/2),houghspace_size(2),houghspace_size(3)],index);
a4 = a4(2) + floor(houghspace_size(1)/2);
b4 = b4(2);
r4 = r4(2) + rmin;
x = a4 + r4*cos(alpha);
y = b4 + r4*sin(alpha);
plot(y,x,'-');
%%
% 利用得到的圆心和半径制作mask
eye_R_mask = ones(size(Eye_R_bw));
[m,n] = size(eye_R_mask);
for i = 1:m
    for j = 1:n
        D1 = sqrt((i-a1)^2+(j-b1)^2);
        D2 = sqrt((i-a2)^2+(j-b2)^2);
        D3 = sqrt((i-a3)^2+(j-b3)^2);
        D4 = sqrt((i-a4)^2+(j-b4)^2);
        if (D1<=r1&&D2>=r2&&D3<=r3&&D4<=r4)
            eye_R_mask(i,j) = 0;
        end
    end
end
subplot(1,2,2);imshow(im2double(Eye_R) .* eye_R_mask);
title("右眼去除瞳孔");
%%
% 对左眼进行二值化和边缘检测
Eye_L_bw = imbinarize(Eye_L,0.5);
mask = false(size(Eye_L_bw));
mask(100:270,:) = true;
h=fspecial('gaussian',5);
Eye_L_bw = imfilter(Eye_L_bw,h);
Eye_L_edge = edge(Eye_L_bw,'canny');
Eye_L_edge = Eye_L_edge .* mask;
figure(3);
subplot(1,2,1);imshow(Eye_L_edge);hold on;
title('左眼霍夫变换检测圆');
%%
% 检测左眼外圆
rmin = 60;
houghspace_eye_L = Hough(Eye_L_edge,rmin,rmin+30,pi/100);
houghspace_size = size(houghspace_eye_L);
max_hough = max(max(max(houghspace_eye_L)));
index = find(houghspace_eye_L == max_hough);
[a1,b1,r1] = ind2sub(houghspace_size,index);
alpha = 0:pi/100:2*pi;
r1 = r1 + rmin;
x = a1 + r1*cos(alpha);
y = b1 + r1*sin(alpha);
plot(y,x,'-');
%%
% 检测左眼内圆
rmin = 20;
houghspace_eye_L = Hough(Eye_L_edge,rmin,rmin+10,pi/100);
houghspace_size = size(houghspace_eye_L(a1-5:a1+5,b1-5:b1+5,:));
max_hough = max(max(max(houghspace_eye_L(a1-5:a1+5,b1-5:b1+5,:))));
index = find(houghspace_eye_L(a1-5:a1+5,b1-5:b1+5,:) == max_hough);
[a2,b2,r2] = ind2sub([10,10,houghspace_size(3)],index);
a2 = a2 + a1 - 5;
b2 = b2 + b1 - 5;
r2 = r2+rmin;
x = a2 + r2*cos(alpha);
y = b2 + r2*sin(alpha);
plot(y,x,'-');
%%
% 检测左眼上下眼睑
rmin = 170;
houghspace_eye_L = Hough(Eye_R_edge,rmin,rmin+30,pi/100);
houghspace_size = size(houghspace_eye_L);
max_hough = max(max(max(houghspace_eye_L)));
index = find(houghspace_eye_L == max_hough);
[a3,b3,r3] = ind2sub(houghspace_size,index);
r3 = r3+rmin;
x = a3 + r3*cos(alpha);
y = b3 + r3*sin(alpha);
plot(y,x,'-');
rmin = 200;
houghspace_eye_L = Hough(Eye_R_edge,rmin,rmin+10,pi/100);
max_hough = max(max(max(houghspace_eye_L(floor(houghspace_size(1)/2):end,:,:))));
index = find(houghspace_eye_L(floor(houghspace_size(1)/2):end,:,:) == max_hough);
[a4,b4,r4] = ind2sub([ceil(houghspace_size(1)/2),houghspace_size(2),houghspace_size(3)],index);
a4 = a4(2) + floor(houghspace_size(1)/2);
b4 = b4(2);
r4 = r4(2) + rmin;
x = a4 + r4*cos(alpha);
y = b4 + r4*sin(alpha);
plot(y,x,'-');
%%
% 根据检测得到的圆心和半径制作mask
eye_L_mask = ones(size(Eye_L_bw));
[m,n] = size(eye_L_mask);
for i = 1:m
    for j = 1:n
        D1 = sqrt((i-a1)^2+(j-b1)^2);
        D2 = sqrt((i-a2)^2+(j-b2)^2);
        D3 = sqrt((i-a3)^2+(j-b3)^2);
        D4 = sqrt((i-a4)^2+(j-b4)^2);
        if (D1<=r1&&D2>=r2&&D3<=r3&&D4<=r4)
            eye_L_mask(i,j) = 0;
        end
    end
end
subplot(1,2,2);imshow(im2double(Eye_L) .* eye_L_mask);
title('左眼去除瞳孔');
%%
% 制作总体的mask并修改瞳孔颜色，以RGB值(0.2,0.5,0.3)为范例
total_mask = ones(size(I_gray));
total_mask(270:700,229:695) = eye_R_mask;
total_mask(250:600,866:1310) = eye_L_mask;
new_I = im2double(I);
new_I(:,:,1) = new_I(:,:,1) .* total_mask;
new_I(:,:,2) = new_I(:,:,2) .* total_mask;
new_I(:,:,3) = new_I(:,:,3) .* total_mask;
new_I(:,:,1) = new_I(:,:,1) + ~total_mask*0.2;
new_I(:,:,2) = new_I(:,:,2) + ~total_mask*0.5;
new_I(:,:,3) = new_I(:,:,3) + ~total_mask*0.3;
figure(4);
suptitle('更换瞳孔颜色');
imshow(new_I);