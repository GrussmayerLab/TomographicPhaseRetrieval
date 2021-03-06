% stack = cropCoregMask(stack)
% ---------------------------------------
%
% Only for Multi-Plane data
% Detect and remove the coregistration mask of MP data
%
% Inputs:
%  stack        Input coregistered Multi-Plane data
%
% Outputs:
%  stack        Output cropped data
%
% ---------------------------------------
% A detailled description of the theory supporting this program can be found in : 
% "Descloux, A., et al. "Combined multi-plane phase retrieval and 
%  super-resolution optical fluctuation imaging for 4D cell microscopy." 
%  Nature Photonics 12.3 (2018): 165."
%
%   Copyright ? 2018 Adrien Descloux - adrien.descloux@epfl.ch, 
%   ?cole Polytechnique F?d?rale de Lausanne, LBEN/LOB,
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

function stack = cropCoregMask(stack)

    temp = stack ~= 0;
    mask = sum(temp,3); mask = (mask == 8); 
    masky = (sum(mask,2)./Nx > 0.5);
    [~,ay] = max(masky); [~,by] = max(masky(end:-1:1)); by = length(masky)-by+1;
    maskx = (sum(mask,1)./Nx > 0.5);
    [~,ax] = max(maskx); [~,bx] = max(maskx(end:-1:1)); bx = length(maskx)-bx+1;
    temp_nPix = min(bx-ax+1,by-ay+1);
    stack = stack(ay:temp_nPix-1+ay,ax:temp_nPix+ax-1,:);
    
end