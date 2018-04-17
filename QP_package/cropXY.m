% out = cropXY(input,N)
% ---------------------------------------
%
% This function crop the input 3D stack to have the size [N,N,~]
% if N > than Nx or Ny/ not given, it make sure that the resulting image is square
%
% Inputs:
%  input        2D/3D data
%  N            Size of the cropped image
%               if not set, crop the image to min(size(N,1),size(N,2))
% Outputs:
%  out        	Cropped data
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

function out = cropXY(input,N)
[Nx,Ny,~] = size(input);
if nargin < 2; N = max(Nx,Ny)+1;end

if N > max(Nx,Ny) % invalid/ missing input N => square the stack
    if Nx~=Ny
        N = min(Nx,Ny);
        ox = floor((Nx-N)/2); oy = floor((Ny-N)/2);
        out = input(ox+1:ox+N,oy+1:oy+N,:);
    else
        out = input;
    end
else
    ox = floor((Nx-N)/2); oy = floor((Ny-N)/2);
    out = input(ox+1:ox+N,oy+1:oy+N,:);
end

end

