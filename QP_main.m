% This file contains a basic pipeline for QP retrieval from brightfield stacks
% - 3D image stack loading
% - 3D stack preprocessing
% - processing parameters definition
% - phase calculation
% - display of the results
% ---------------------------------------
%
% A detailled description of the theory supporting this program can be found in : 
% "Descloux, A., et al. "Combined multi-plane phase retrieval and 
%  super-resolution optical fluctuation imaging for 4D cell microscopy." 
%  Nature Photonics 12.3 (2018): 165."
%
%
%   Copyright © 2018 Adrien Descloux - adrien.descloux@epfl.ch, 
%   École Polytechnique Fédérale de Lausanne, LBEN/LOB,
%   BM 5.134, Station 17, 1015 Lausanne, Switzerland.
%
%    This program is free software: you can redistribute it and/or modify
%    it under the terms of the GNU General Public License as published by
%    the Free Software Foundation, either version 3 of the License, or
%    (at your option) any later version.
%
%    This program is distributed in the hope that it will be useful,
%    but WITHOUT ANY WARRANTY; without even the implied warranty of
%    MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
%    GNU General Public License for more details.
%
%    You should have received a copy of the GNU General Public License
%    along with this program.  If not, see <http://www.gnu.org/licenses/>.
%

%% set path
addpath('QP_package')

%% 3D image stack loading
[stack,pname,fname] = loadData;
[Nx,Ny,Nz] = size(stack);

%% 3D stack preprocessing 
if Nz == 8 % i.e. multiplane data : remove the coregistration mask
    stack = cropCoregMask(stack); 
    stack = cropXY(stack,temp_nPix-4); % extra safety crop 
else
    stack = cropXY(stack); %% crop the stack to have a square image
end
    [Nx,Ny,Nz] = size(stack);
    
%% Phase retrieval
% define optics and processing parameters
s = setup_phase_default;
s.optics.kzT = 0.01;            % Axial cutoff frequency.
                            % if set to [], use the theoretical value
s.proc.mirrorX = 0 ;            % mirror the input stack along X 
s.proc.mirrorZ = 1 ;            % mirror the input stack along Z
s.proc.applyFourierMask = 1 ;

% set experimental parameters
if size(stack,3) == 8 % i.e. MultiPlane data
    s.optics.dz = 0.35; % [um]
else
    s.optics.dz = 0.2; % typical sampling for fixed cells
end

% compute the phase
QP = getQP(stack,s);

% custom 3D stack plotting 
plotStack(QP)
