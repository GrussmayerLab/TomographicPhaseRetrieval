% Author : Adrien Descloux
% Date : 04 March 2018
% Version : 2.0

% Basic function to load data stack from a specified path
% If no path are provided, the user can manually select the data
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