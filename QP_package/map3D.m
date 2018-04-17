% out = map3D(in);
% ---------------------------------------
%
% map a kz,klat 2D CTF into its kx,ky,kz 3D circular symetric counterpart
%
% Inputs:
%   in          2D image [kz klat] (klat=sqrt(kx^2+ky^2);)
%
% Outputs:
%   out         3D circular symetric [kx,ky,kz]
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

function out = map3D(in)

[Nz,Nx] = size(in);

temp_x = linspace(-1,1,Nx);temp_z = linspace(-1,1,Nz);
[tX,tY] = meshgrid(temp_x,temp_x);
r = sqrt(tX.^2 + tY.^2);
r(r > max(temp_x)) = max(temp_x);

mapr = (r-min(temp_x))./(max(temp_x)-min(temp_x)).*(length(temp_x)-2);
mapf = floor(mapr)+1; mapc = ceil(mapr)+1;
p = mapc-mapr-1;

out = zeros(length(temp_x),length(temp_x),length(temp_z));
for kk = 1:length(temp_z)
    
    CTF1D = in(kk,:);           % extract the 1D psf
    tempf = CTF1D(mapf);      	% map the 1D psf on a polar grid
    tempc = CTF1D(mapc);       	% map the 1D psf on a polar grid
        
    % local linear interpolation 
    temp     = p.*tempf + (1-p).*tempc;
    
    out(:,:,kk) = temp;        % store the 2D psf
end

end
