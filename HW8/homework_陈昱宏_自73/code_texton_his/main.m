

% data��Ϊѵ���������Ͳ���������������ѵ����������ÿ����ǩ����һ��ͼƬ����������������ʣ�µ�ͼƬ
data_dir = '..\data'; % Set this to the location of your data directory
[train_samples,test_samples] = sample_select(data_dir);


disp = 1;
% �����˲�����
fb = makeFilterbank();
%% ѵ��
% ���������е�ÿ��ͼƬ����ͼƬ���˲�������Ӧ,��������������Ӧ
samples_res = applyFilterbank(train_samples,fb);

% ����������Ӧ�У���ÿ�����ؽ���k-means���࣬k=20���Ƽ�ʹ��kmeans����
k = 20;
tic;
[samples_cluster,centers] = applyKmeans(samples_res,k);
t = toc;

% ��ȡ��������ÿ��ͼƬ��textonֱ��ͼ
samples_hist = applyHistogram(samples_cluster);
%%
if disp == 1
    % ���ӻ�������
    visualizeSamples(samples_cluster)
    %���ӻ���������ÿ��ͼƬ��ֱ��ͼ
    visualizeHistogram(samples_hist);
end

%% ����
% �Բ��Լ��е�ÿ��ͼƬ�����˲�������Ӧ
test_samples_res = applyFilterbank(test_samples,fb);

% ��ÿ�����ؽ��й���,�Ƽ�ʹ��pdist2����
test_samples_cluster = predictClasses(test_samples_res,centers);

% ��ȡ����ͼƬ��textonֱ��ͼ
test_samples_hist = applyHistogram(test_samples_cluster);

% ������㷨Ԥ�����
test_samples_predict = predictLabels(test_samples_hist,samples_hist);

% ����׼ȷ��
accuracy = evalPredict(test_samples_predict,test_samples);