function visualizeSamples(samples_cluster)
% visualize the samples result
%�Լ�����RGBֵ
color_map = [0,0,0;0,0,0.5;0,0,1;0,0.5,0;0,0.5,0.5;0,0.5,1;0,1,0;0,1,0.5;0,1,1;0.5,0,0;0.5,0,0.5;0.5,0,1;0.5,0.5,0;0.5,0.5,0.5;0.5,0.5,1;0.5,1,0;0.5,1,0.5;0.5,1,1;1,0,0;1,0,0.5;0,0,0.2;0,0,0.4;0,0,0.6;0,0.2,0;0,0.4,0.2;0,0.8,0.4;0,0.6,0.2;0,0.8,0.1;0,0.7,0.2;0.7,0,0;0.7,0,0.2;0.7,0,0.8;0.7,0.3,0;0.7,0.2,0.3;0.7,0.4,1;0.7,1,0.8;0.9,1,0.2;0.9,0.2,1;0.3,0.2,0;1,0,0.9];
for i = 1:5
    I = zeros(480,640,3);
    for j = 1:480
        for k = 1:640
            I(j,k,1:3) = color_map(samples_cluster(i,j,k),:);
        end
    end
    I = round(I * 255);
    figure,imshow(I);
end