classdef S2VectorFieldHarmonic < S2VectorField
% a class represeneting a function on the sphere

properties
  sF_theta
  sF_rho
  sF_n
end

methods

  function sVF = S2VectorFieldHarmonic(sF_theta, sF_rho, varargin)
    % initialize a spherical vector field
    if nargin == 0, return; end

    sVF.sF_theta = sF_theta;
    sVF.sF_rho = sF_rho;
    if ( nargin > 2 ) && ( isa(varargin{1}, 'S2Fun') )
      sVF.sF_n = varargin{1};
    else
      sVF.sF_n = S2FunHarmonic(0);
    end

  end

end

methods(Static = true)
  sVF = quadrature(f, varargin)
end

end