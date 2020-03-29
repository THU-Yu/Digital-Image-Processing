function visualizeHistogram(samples_hist)
% visualize histogram result of the samples
for i = 1:5
    figure,bar(samples_hist(i,:));
end