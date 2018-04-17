% [im,pname,fname] = loadData(path);
% ---------------------------------------
%
% Basic function to load tif data stack from a specified path
% If no path are provided, the user can manually select the data
%
% Inputs:
%  path         Full path of the data
%
% Outputs:
%  im        	Data stack
%  pname        Path name
%  fname        File name
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

function [im,pname,fname] = loadData(path)
if nargin < 1
    [fname,pname] = uigetfile('*.*');
    path = [pname,filesep,fname];
end
    

keepReading = 1; k = 1;
warning('off')
while keepReading 
    try
        im(:,:,k) = imread(path,'Index',k);
        k = k+1;
    catch
        keepReading = 0;
        disp('Finished reading... ')
        disp(['Stack size : ',num2str(size(im))])
    end
end
warning('on')