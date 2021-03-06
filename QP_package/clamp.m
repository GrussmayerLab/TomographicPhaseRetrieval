% val = clamp(val,minVal,maxVal)
% ---------------------------------------
%
% Clamp the variable "val" between [minVal maxVal]
% if minVal = [] : no lower bound
% if maxVal = [] : no upper bound
%
% Inputs:
%  val          Input coregistered Multi-Plane data
%  minVal       Minimum boundary
%  maxVal       Maximum boundary
%
% Outputs:
%  val        	Clampped value
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

function val = clamp(val,minVal,maxVal)

if isempty(minVal) % no lower bound
    mapmax = val > maxVal;
    val(mapmax) = maxVal;
end
if isempty(maxVal) % no upper bound
    mapmin = val < minVal;
    val(mapmin) = minVal;
end
if ~isempty(minVal) && ~isempty(maxVal)
    mapmax = val > maxVal;
    val(mapmax) = maxVal;
    
    mapmin = val < minVal;
    val(mapmin) = minVal;
end