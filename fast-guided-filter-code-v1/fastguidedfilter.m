function q = fastguidedfilter(I, p, r, eps, s)
%   GUIDEDFILTER   O(1) time implementation of guided filter.
%
%   - guidance image: I (should be a gray-scale/single channel image)
%   - filtering input image: p (should be a gray-scale/single channel image)
%   - local window radius: r
%   - regularization parameter: eps
%   - subsampling ratio: s (try s = r/4 to s=r)

I_sub = imresize(I, 1/s, 'nearest'); % NN is often enough
p_sub = imresize(p, 1/s, 'nearest');
r_sub = r / s; % make sure this is an integer

[hei, wid] = size(I_sub);
N = boxfilter(ones(hei, wid), r_sub); % the size of each local patch; N=(2r+1)^2 except for boundary pixels.

mean_I = boxfilter(I_sub, r_sub) ./ N;
mean_p = boxfilter(p_sub, r_sub) ./ N;
mean_Ip = boxfilter(I_sub.*p_sub, r_sub) ./ N;
cov_Ip = mean_Ip - mean_I .* mean_p; % this is the covariance of (I, p) in each local patch.

mean_II = boxfilter(I_sub.*I_sub, r_sub) ./ N;
var_I = mean_II - mean_I .* mean_I;

a = cov_Ip ./ (var_I + eps);
b = mean_p - a .* mean_I;

mean_a = boxfilter(a, r_sub) ./ N;
mean_b = boxfilter(b, r_sub) ./ N;

mean_a = imresize(mean_a, [size(I, 1), size(I, 2)], 'bilinear'); % bilinear is recommended
mean_b = imresize(mean_b, [size(I, 1), size(I, 2)], 'bilinear');

q = mean_a .* I + mean_b;
end