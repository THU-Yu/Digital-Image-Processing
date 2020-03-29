function [train_samples,test_samples] = sample_select(data_dir)

%读入数据和标签

trainDataDir = fullfile(data_dir, 'uiuc_texture','train_data');
testDataDir = fullfile(data_dir, 'uiuc_texture','test_data');

% Load all the image names
files = dir(fullfile(trainDataDir, '*.jpg'));
train_samples.image = cell(length(files),1);
train_samples.class = cell(length(files),1);
for i = 1:length(train_samples.class)
    train_samples.image{i} = files(i).name;
    ind = strfind(train_samples.image{i}, '_');
    train_samples.class{i} = train_samples.image{i}(1:ind(1)-1);
end
[~,~,train_samples.classId] = unique(train_samples.class);

% Load all the image names
files = dir(fullfile(testDataDir, '*.jpg'));
test_samples.image = cell(length(files),1);
test_samples.class = cell(length(files),1);
for i = 1:length(test_samples.class)
    test_samples.image{i} = files(i).name;
    ind = strfind(test_samples.image{i}, '_');
    test_samples.class{i} = test_samples.image{i}(1:ind(1)-1);
end
[~,~,test_samples.classId] = unique(test_samples.class);