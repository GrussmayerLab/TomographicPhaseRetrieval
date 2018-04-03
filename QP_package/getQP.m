% Author : Adrien Descloux
% Date : 04 March 2018
% Version : 2.1

% Recover the Cross-spectral density from the intensity stack

% The theory supporting this m-file can be found in : 
% "Descloux, A., et al. "Combined multi-plane phase retrieval and 
%  super-resolution optical fluctuation imaging for 4D cell microscopy." 
%  Nature Photonics 12.3 (2018): 165."

% the private parameters are optimized for the MP-sofi setup

% input parameters :
    % stack : 3D intensity stack
    % mask : use precomputed mask for fast reconstruction
% output parameters :
    % QP : Quantitative Phase
    % mask : return the mask used for the reconstruction
function [QP,mask] = getQP(stack,s,mask)

if nargin < 3 % if no mask are provided
% mirror the data and compute adequate Fourier space grid
[stackM,kx,kz] = getMirroredStack(stack,s);

% compute usefull stuff
th = asin(s.optics.NA/s.optics.n);
th_ill = asin(s.optics.NA_ill/s.optics.n);
k0max = s.optics.n*2*pi/(s.optics.lambda - s.optics.dlambda/2);
k0min = s.optics.n*2*pi/(s.optics.lambda + s.optics.dlambda/2);

% compute Fourier space grid and the phase mask
[Kx,Kz] = meshgrid(kx,kz);
if isempty(s.optics.kzT)
    mask2D = Kz > k0max*(1-cos(th_ill));
else
    mask2D = Kz > s.optics.kzT;
end

if s.proc.applyFourierMask % => compute the CTF mask for extra denoising
% CTF theory 
maskCTF = ((Kx-k0max*sin(th_ill)).^2 + (Kz-k0max*cos(th_ill)).^2 <= k0max^2) & ...
          ((Kx+k0min*sin(th_ill)).^2 + (Kz-k0min).^2 >= k0min.^2) & ...
          Kx>=0 & ...
          Kz < k0max*(1-cos(th));
maskCTF = maskCTF | maskCTF(:,end:-1:1);
mask2D = mask2D & maskCTF;
end

% since we assume a circular symetric CTF, we expand the 2Dmask in 3D
mask = map3D(mask2D);

end

% Cross-Spectral Density calculation
Ik = fftshift(fftn(fftshift(stackM)));

Gamma = Ik.*mask; % cross-spectral density

csd = ifftshift(ifftn(ifftshift(Gamma)));
csd = csd(1:size(stack,1),1:size(stack,2),1:size(stack,3)); % remove the mirrored input

QP = angle(csd + mean(stack(:))/s.optics.alpha);

end