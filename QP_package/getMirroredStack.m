% [QP,mask] = getQP(stack,s,mask)
% ---------------------------------------
%
% Mirror the data stack according to the structure s (see "setup_phase.m")
% Compute corresponding reciprocal space kx,kz according to the mirroring
%
% Inputs:
%  stack        Input intensity 3D stack
%  s            Structure containing all optics and processing parameters
%                   see "setup_phase_default.m"
%  mask         Precomputed mask for fast reconstruction
%
% Outputs:
%  QP        	Quantitative phase
%  mask         Mask used to filter the intensity stack
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

function [stackM,kx,kz] = getMirroredStack(stack,s)

[Nx,Ny,Nz] = size(stack);

if Nx ~= Ny % verify that the stack is square
   stack = cropXY(stack); % if not, crop it
end
% compute real space
x = linspace(-Nx*s.optics.dx/2,Nx*s.optics.dx/2,Nx);
z = linspace(-Nz*s.optics.dz/2,Nz*s.optics.dz/2,Nz);

temp = stack;
if s.proc.mirrorZ
    t = temp;
    t(:,:,end+1:2*end) = temp(:,:,end:-1:1);
    temp = t;
    kz = 2*pi/(max(z)-min(z)).*linspace(-Nz/2,(Nz-1)/2,2*Nz);
else
    if mod(Nz,2) % i.e. if Nz is odd
        kz = 2*pi/(max(z)-min(z)).*linspace(-Nz/2,Nz/2,Nz);
    else
        kz = 2*pi/(max(z)-min(z)).*linspace(-Nz/2,Nz/2-1,Nz);
    end
end

if s.proc.mirrorX
    t = temp;
    t(end+1:2*end,:,:) = temp(end:-1:1,:,:);
    t(:,end+1:2*end,:) = t(:,end:-1:1,:);
    temp = t;
    kx = 2*pi/(max(x)-min(x)).*linspace(-Nx/2,(Nx-1)/2,2*Nx);
else
    if mod(Nz,2) % i.e. if Nx is odd
        kx = 2*pi/(max(x)-min(x)).*linspace(-Nx/2,Nx/2,Nx);
    else
        kx = 2*pi/(max(x)-min(x)).*linspace(-Nx/2,Nx/2-1,Nx);
    end
end

stackM = temp;
end