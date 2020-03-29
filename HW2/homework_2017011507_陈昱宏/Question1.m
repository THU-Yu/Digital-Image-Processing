%% 
FolderPath = fullfile('.', 'Ã‚ƒø“ª');
AddNoiseBatch(FolderPath);
%%
%function define
function AddNoiseBatch(FolderPath)
    % find all .jpg image
    file = dir(fullfile(FolderPath, '*.jpg'));
    % add noise to each image
    for i = 1:length(file)
        imagepath = fullfile(FolderPath, file(i).name); 
        %read image
        I1 = imread(imagepath);
        Size = size(I1);
        %check image is rgb or not
        if Size(3) == 3
            I2 = rgb2gray(I1);
        end
        %resize image
        if Size(1) > Size(2)
            I3 = imresize(I2,[1000, floor(1000 * Size(2) / Size(1))], 'bicubic');
        else
            I3 = imresize(I2,[floor(1000 * Size(1) / Size(2)), 1000], 'bicubic');
        end
        %change I3 value from uint8 to double
        I3 = im2double(I3);
        Size3 = size(I3);
        %add noise
        gauss = randn(Size3(1), Size3(2));
        I4_g = I3 + gauss;
        I4 = imadjust(I4_g, [0;1], [0;1], 1);
        %use sbuplot to show image
        figure(i);
        subplot(2,2,1), imshow(I3), title('I3');
        subplot(2,2,2), imshow(I4_g), title('‘Î…˘Õº');
        subplot(2,2,3), imshow(I4), title('I4');
        %link axes
        ax(1) = subplot(2,2,1);
        plot(rand(1,10), 'Parent', ax(1)), imshow(I3), title('I3');
        ax(2) = subplot(2,2,2);
        plot(rand(1,10), 'Parent', ax(2)), imshow(I4_g), title('‘Î…˘Õº');
        ax(3) = subplot(2,2,3);
        plot(rand(1,10), 'Parent', ax(3)), imshow(I4), title('I4');
        linkaxes(ax, 'xy');
        %write image
        imwrite(I4,[imagepath '.bmp']);
        hold on;
    end
end
