function p = feature_significance(x, alpha, epsilon)
% [p,pvals] = feature_significance(x, alpha)
% 
%  INPUT
%   :x - binary matrix in / out of relevant set
%   :alpha - significance level
%  OUTPUT
%   :p - neyman-pearson hypothesis test output
% 
%  BY: Gregory Ditzler
%
if nargin < 3
  epsilon = 0;
end
[n_feat, n_boot] = size(x);
p = zeros(n_feat, 1);
k = sum(x);  % all elements should be the same since same number of
             % features were selected
pvals = zeros(n_feat,1);

if mean(k) == k(1)
  k = k(1);    % so grab the 1st one - they are all the same
else
  disp(['Warning:: Different number of feature selected - Using ',...
    num2str(mode(k))]);
  k = mode(k);
end

X = sum(x,2);
p0 = k/n_feat +epsilon;
p1 = X/n_boot;

if p0 > 1
  error('The bias is too large. Results in an invalid probability on the null hypothesis');
end

z_crit = binoinv(1-alpha, n_boot, p0);
p(z_crit <= X) = 1;
