clear all;
close all;
% 对第一帧进行标记
video = VideoReader('.\data\targetVideo.MP4');
FrameNum = video.Duration * video.FrameRate;
frame = read(video,1);
X = zeros(4,FrameNum);
Y = zeros(4,FrameNum);
imshow(frame);
[X(:,1),Y(:,1)] = ginput(4);% 顺序为左上、右上、右下和左下
hold on;
plot([X(:,1); X(1,1)],[Y(:,1); Y(1,1)],'r-','LineWidth',5);
hold off;
%%
% 开始追踪每一帧，并记录变换后的四个角点坐标
for i = 1:FrameNum - 1
    frame = read(video,i);
    frameNext = read(video,(i+1));
    points1 = detectSURFFeatures(rgb2gray(frame));
    points2 = detectSURFFeatures(rgb2gray(frameNext));
    [frameFeatures,framePoints] = extractFeatures(rgb2gray(frame),points1);
    [frameNextFeatures,frameNextPoints] = extractFeatures(rgb2gray(frameNext),points2);
    framePairs = matchFeatures(frameFeatures,frameNextFeatures);
    matchedframePoints = framePoints(framePairs(:, 1), :);
    matchedframeNextPoints = frameNextPoints(framePairs(:, 2), :);
    [tform,inlierPtsDistorted,inlierPtsOriginal] = ...
    estimateGeometricTransform(matchedframePoints,matchedframeNextPoints,...
    'affine');
    for j = 1:4
        NewPos = [X(j,i),Y(j,i),1] * tform.T;
        X(j,i+1) = NewPos(1);
        Y(j,i+1) = NewPos(2);
    end
    %imshow(frameNext);hold on;
    %plot([X(:,i+1); X(1,i+1)],[Y(:,i+1); Y(1,i+1)],'r-','LineWidth',5);
    %hold off;
end
%%
% 开始写视频
NewVideo = VideoWriter('.\data\newvideo.avi');
NewVideo.FrameRate = video.FrameRate;
open(NewVideo);
NewBook = imread('.\data\Book.jpg');
[h1,w1,c] = size(NewBook);
xs1 = [1 w1 w1 1]';
ys1 = [1 1 h1 h1]';
for i = 1:FrameNum
    targetFrame = read(video,i);
    [h2,w2,c] = size(targetFrame);
    xs2 = X(:,i);
    ys2 = Y(:,i);
    tform = fitgeotrans([xs1 ys1],[xs2 ys2],'projective');
    I = imwarp(NewBook,tform,'OutputView',imref2d(size(targetFrame)));
    mask = sum(I,3)~=0;
    idx = find(mask);
    NewFrame = targetFrame;
    NewFrame(idx) = I(idx);
    NewFrame(idx+h2*w2) = I(idx+h2*w2);
    NewFrame(idx+2*h2*w2) = I(idx+2*h2*w2);
    writeVideo(NewVideo,NewFrame);
end
close(NewVideo);