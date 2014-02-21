function idx = npfs_post(X, alpha, beta)
% [idx, p]=NPFS(data, labels, method, k, n_bootstraps, alpha, delta)
% 
%   Input
%     :data - data in #Obs by #Features matrix
%     :labels - labels in #Obs by 1 vector
%     :alpha - size of the test
%     :beta - bias to reject
%   Output
%     :idx - indices selected by Neyman-Pearson
%     
%   Written by: Gregory Ditzler (2014)
%
%  See also FEATURE_SIGNIFICANCE, GET_FEATURES
x = sum(X);
for i = 2:length(x)
  if x(1) ~= x(i)
    error('The number of features selected at different iterations must be the same');
  end
end
p = feature_significance(Z, alpha, beta); 
idx = find(p == 1);