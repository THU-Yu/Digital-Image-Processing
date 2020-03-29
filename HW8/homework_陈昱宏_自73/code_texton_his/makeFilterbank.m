function fb = makeFilterbank
% Make filter bank. It is convinient to represent this as a [N N 8] array.

% Random filterbank. You should replace this with your implementation.
fb = zeros([10 10 8]);
for i = 1:8
    fb(:,:,i) = fspecial('log',10,i);
end