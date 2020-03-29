function samples_hist = applyHistogram(samples_cluster)
% apply histogram for each image in the sample
% input is the sample
% output is the histogram result

% replace it with your implementation
[dim1,dim2,dim3] = size(samples_cluster);
k = max(max(max(samples_cluster)));
samples_hist = zeros(dim1,k);
for i = 1:dim1
    for j = 1:k
        [x,y] = find(samples_cluster(i,:,:) == j);
        shape = size(x);
        samples_hist(i,j) = shape(1) / (dim2*dim3);
    end
end
