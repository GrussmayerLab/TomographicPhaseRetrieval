% Author : Adrien Descloux
% Date : 04 March 2018
% Version : 2.0

% run this file to get the structure "s" required for QP reconstruction
function s = setup_phase

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
                         
% processing parameters
s.proc.mirrorX = 0 ;            % mirror the input stack along X 
s.proc.mirrorZ = 1 ;            % mirror the input stack along Z
s.proc.applyFourierMask = 0 ;   % apply the denoising Fourier mask

end