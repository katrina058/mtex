function sF = calcDensity(v,varargin)
% calculate a density function out of (weighted) unit vectors
%
% Syntax
%
%   sF = calcDensity(v)
%   sF = calcDensity(v,'weights',w)
%   sF = calcDensity(v,'halfwidth',delta)
%   sF = calcDensity(v,'kernel',psi)
%    f = calcDensity(v,S2G)
%
% Input
%  v   - sampling points for density estimation @vector3d
%  S2G - @vector3d
%  w   - weights, default is all one
%  delta - halfwidth of the kernel, default is 10 degree
%  psi - @kernel function, default is de la Vallee Poussin
%
% Output
%  sF  - @sphFun
%   f  - function values
%
% Options
%  halfwidth - halfwidth of a kernel
%  kernel    - specify a kernel
%  weights   - vector of weights, with same length as v
%

% determine kernel function
hw = get_option(varargin,'halfwidth',10*degree);
psi = get_option(varargin,'kernel',deLaValeePoussinKernel('halfwidth',hw));
c = get_option(varargin,'weights',ones(length(v),1));

% todo strange factor here??
c = 4*pi*c./sum(c);

% 
sF = sphFunHarmonic.quadrature(c,v,varargin{:});

%
sF = conv(sF,psi);

% if required compute function values
if nargin > 1 && isa(varargin{1},'vector3d')
  sF = sF.eval(varargin{1}); 
end