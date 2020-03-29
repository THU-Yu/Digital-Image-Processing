%% 
% read image

ImagePath = fullfile('.', 'ÌâÄ¿¶þ', '0.jpg');
image = imread(ImagePath);
Mask = imread(fullfile('.', 'mask.png'));
%% 
% resize Mask

ImageSize = size(image);
MaskSize = size(Mask);
Mask = imadjust(Mask, [0;1], [1;0], 1);
%create white picture(size is same as image)
Pic = zeros([MaskSize(1), MaskSize(2), MaskSize(3)]);
Pic = uint8(Pic);
Pic = Pic + Mask;
%resize Mask and set Mask to part of Pic
if (ImageSize(1) / ImageSize(2)) > (MaskSize(1) / MaskSize(2))
    image = imresize(image, [MaskSize(1), MaskSize(1) * ImageSize(2) / ImageSize(1)], 'bicubic');
    ImageSize = size(image);
    Start = floor(MaskSize(2) / 2) - floor(ImageSize(2) / 2);
    End = Start + ImageSize(2) - 1;
    Pic(1:MaskSize(1), Start:End, 1:3) = image(1:ImageSize(1), 1:ImageSize(2), 1:3) + Pic(1:MaskSize(1), Start:End, 1:3);
else
    image = imresize(image, [MaskSize(2) * ImageSize(1) / ImageSize(2), MaskSize(2)], 'bicubic');
    ImageSize = size(image);
    Start = floor(MaskSize(1) / 2) - floor(ImageSize(1) / 2);
    End = Start + ImageSize(1) - 1;
    Pic(Start:End, 1:MaskSize(2), 1:3) = image(1:ImageSize(1), 1:ImageSize(2), 1:3) + Pic(Start:End, 1:MaskSize(2), 1:3);
end
Size = floor(min(MaskSize(1), MaskSize(2)) / 3);
Pic1 = Pic(1:Size, 1:Size, 1:3);
Pic2 = Pic(Size + 1:Size * 2, 1:Size, 1:3);
Pic3 = Pic(Size * 2 + 1:MaskSize(1), 1:Size, 1:3);
Pic4 = Pic(1:Size, Size + 1:Size * 2, 1:3);
Pic5 = Pic(Size + 1:Size * 2, Size + 1:Size * 2, 1:3);
Pic6 = Pic(Size * 2 + 1:MaskSize(1), Size + 1:Size * 2, 1:3);
Pic7 = Pic(1:Size, Size * 2 + 1:MaskSize(2), 1:3);
Pic8 = Pic(Size + 1:Size * 2, Size * 2 + 1:MaskSize(2), 1:3);
Pic9 = Pic(Size * 2 + 1:MaskSize(1), Size * 2 + 1:MaskSize(2), 1:3);
imshow(Pic);
imwrite(Pic1, fullfile('.', 'Data', 'MyPic1.jpg'));
imwrite(Pic2, fullfile('.', 'Data', 'MyPic2.jpg'));
imwrite(Pic3, fullfile('.', 'Data', 'MyPic3.jpg'));
imwrite(Pic4, fullfile('.', 'Data', 'MyPic4.jpg'));
imwrite(Pic5, fullfile('.', 'Data', 'MyPic5.jpg'));
imwrite(Pic6, fullfile('.', 'Data', 'MyPic6.jpg'));
imwrite(Pic7, fullfile('.', 'Data', 'MyPic7.jpg'));
imwrite(Pic8, fullfile('.', 'Data', 'MyPic8.jpg'));
imwrite(Pic9, fullfile('.', 'Data', 'MyPic9.jpg'));