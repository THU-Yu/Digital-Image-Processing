function samples_res = applyFilterbank(train_samples,fb)
% apply Filter into the images of the sample,
% input is the images sample and filter bank
% output is the filter respons of the images sample

% replace it with your implementation
[m,n] = size(train_samples.image);
if m == 5
    dataDir = fullfile('..\data', 'uiuc_texture','train_data');
else
    dataDir = fullfile('..\data', 'uiuc_texture','test_data');
end
samples_res = zeros(m,480,640,8);
for i = 1:m
    I = imread(fullfile(dataDir,string(train_samples.image(i))));
    for j = 1:8
        samples_res(i,:,:,j) = imfilter(I,fb(:,:,j));
    end
end