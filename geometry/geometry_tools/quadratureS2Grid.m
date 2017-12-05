function [S2G, W, M2] = quadratureS2Grid(M, varargin)
%
% [S2G, W, M2] = get_quadrature_grid(M) quadrature grid of type gauss
% [S2G, W, M2] = get_quadrature_grid(M, 'chebyshev') quadrature grid of thype chebyshev
%

path = mfilename('fullpath');
if check_option(varargin, 'gauss')
	path = [mtex_path '/data/quadratureS2Grid_gauss/'];
else
	path = [mtex_path '/data/quadratureS2Grid_chebyshev/'];
end
files = dir( fullfile(path,'*') );
tmp = {files.name}';
tmp = char(tmp);
tmp = mat2cell(tmp(:, 2:5), ones(length(tmp), 1));
tmp = str2double(tmp);
tmp2 = (tmp >= M);
index = find(tmp2, 1);
if isempty(index)
	index = length(tmp);
	warning('M is too large, instead we are giving you the largest quadrature grid we got.');
end

M2 = tmp(index);

data = load([path, files(index).name]);
S2G = vector3d('polar', data(:, 1), data(:, 2));

if check_option(varargin, 'gauss')
	W = data(:, 3);
else
	W = 4*pi/size(data, 1);
end

end