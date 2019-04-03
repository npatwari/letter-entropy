%
% Purpose: Calculate the entropy in a pmf or histogram
%
% Author: Neal Patwari
% 

function H = entropy(n)

% Matlab doesn't like 0*log(0), so:
ind = find(n>0);

% Normalize to sum to 1:
S = sum(n);
x = n(ind)./S;

% Formula for entropy
H = - sum(x.*log2(x));
