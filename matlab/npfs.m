function idx = npfs(data, labels, method, k, n_bootstraps, alpha, delta)
% [idx, p]=NPFS(data, labels, method, k, n_bootstraps, alpha, delta)
% 
%   Input
%     :data - data in #Obs by #Features matrix
%     :labels - labels in #Obs by 1 vector
%     :method - feature selection method (see FEAST for help)
%     :k - number of features to select
%     :n_bootstraps - number of bootstraps
%     :alpha - size of the test
%     :delta - bias to reject
%   Output
%     :idx - indices selected by Neyman-Pearson
%     
%   Written by: Gregory Ditzler (2013)
%
%  See also FEATURE_SIGNIFICANCE, GET_FEATURES
[n_observations, n_features] = size(data);

V = zeros(n_features, n_bootstraps);
parfor b = 1:n_bootstraps
  ibs = randsample(1:n_observations, floor(.75*n_observations), true, ...
    ones(1,n_observations)/n_observations);
  Xp = data(ibs,:);
  Yp = labels(ibs);
  
  %i = randperm(size(Xp, 2));
  %Xp = Xp(:, i);
  VV = get_features(Xp, Yp, k, method)';
  V(:, b) = VV;
end
p = feature_significance(V, alpha, delta); 
idx = find(p == 1);

% function to run NPFS
function V = get_features(data, labels, n_select, method)
selected_features = feast(method, n_select, data, labels);
V = zeros(1, size(data,2))';
V(selected_features) = 1;
