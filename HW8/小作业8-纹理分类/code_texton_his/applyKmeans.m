function [samples_cluster,centers] = applyKmeans(samples_res,k)
% apply kmeans algorithm to cluster all pixels into k classes.
% input are the samples responses and class numbers 
% output are the samples cluster result and kmeans centers
% personnally I recommand function 'kmeans', you can learn how 
% to use it by 'doc kmeans' or 'help kmeans'

% replace it with your implementation
[dim1,dim2,dim3,dim4] = size(samples_res);
samples_res = reshape(samples_res,[],dim4);
[samples_cluster,centers] = kmeans(samples_res,k,'Start','uniform','MaxIter',1000);
samples_cluster = reshape(samples_cluster,dim1,dim2,dim3,1);