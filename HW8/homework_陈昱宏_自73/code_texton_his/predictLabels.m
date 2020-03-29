function test_samples_labels = predictLabels(test_samples_hist,train_sample_hist)
% predict the labels of each image in the test sample according to the
% train sample histograms
% inputs are the test sample histograms and train sample histograms
% output is the label prediction result of the test samples
% personally I recommend function 'pdist2', you can learn more about the
% function by 'doc pdist2' or 'doc pdist2'

% replace it with your implementation
test_samples_labels.classId = zeros([25,1]);
[~,idx_test] = pdist2(train_sample_hist,test_samples_hist,'euclidean','Smallest',1);
test_samples_labels.classId = reshape(idx_test,[],1);