classdef sphFunHarmonic < sphFun
% a class represeneting a function on the sphere

properties
	fhat = []  % harmonic coefficients

end

methods
	function sF = sphFunHarmonic(fhat, varargin)
	% initialize a spherical function
		sF.fhat = fhat;
	end

end    

methods (Static = true)
	sF = approximation(v, y, varargin);
	sF = quadrature(f, varargin);

end
end