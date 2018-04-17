% s = setup_phase_default;
% ---------------------------------------
%
% this file return a structure required for Quanatitative Phase reconstruction
%
% Inputs:
%  -
%
% Outputs:
%  s        Structure containing experimental and processing parameters
%
% ---------------------------------------
% A detailled description of the theory supporting this program can be found in : 
% "Descloux, A., et al. "Combined multi-plane phase retrieval and 
%  super-resolution optical fluctuation imaging for 4D cell microscopy." 
%  Nature Photonics 12.3 (2018): 165."
%
%   Copyright © 2018 Adrien Descloux - adrien.descloux@epfl.ch, 
%   École Polytechnique Fédérale de Lausanne, LBEN/LOB,
%   BM 5.134, Station 17, 1015 Lausanne, Switzerland.
%
%  	This program is free software: you can redistribute it and/or modify
%  	it under the terms of the GNU General Public License as published by
% 	the Free Software Foundation, either version 3 of the License, or
%  	(at your option) any later version.
%
%  	This program is distributed in the hope that it will be useful,
%  	but WITHOUT ANY WARRANTY; without even the implied warranty of
%  	MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
%  	GNU General Public License for more details.
%
% 	You should have received a copy of the GNU General Public License
%  	along with this program.  If not, see <http://www.gnu.org/licenses/>.

function s = setup_phase_default

% optics parameters
s.optics.dx = 0.11 ;        % projected pixel size [um]
s.optics.dz = 0.2 ;         % axial sampling [um]
s.optics.NA = 1.2;          % Numerical Aperture detection
s.optics.NA_ill = 0.26 ;    % Numerical Aperture illumination
s.optics.n = 1.33;          % refractive index
s.optics.lambda = 0.58 ;    % Central wavelength in vacuum
s.optics.dlambda = 0.075 ;  % Spectrum bandwidth
s.optics.alpha = 3.15 ;     % Experimental coeficient for QP "normalisation"
s.optics.kzT = 0.01 ;       % Axial cutoff frequency.
                            % if set to [], use the theoretical value
% Practical note : Inacurate values of illumination NA and source spectrum
% in conjunction with coarse z-sampling may lead to an overestimation of
% the axial cutoff if the theoretical value is used.
% Best practice is to use a small value > 0
                            
% processing parameters
s.proc.mirrorX = false ;            % mirror the input stack along X 
s.proc.mirrorZ = true ;            % mirror the input stack along Z
s.proc.applyFourierMask = true ;   % apply the denoising Fourier mask

end