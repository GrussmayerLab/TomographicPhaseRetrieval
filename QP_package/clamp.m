% Author : Adrien Descloux
% Date : 04 March 2018
% Version : 2.0

% Clamp the variable "val" between [minVal maxVal]
% if minVal = [] : no lower bound
% if maxVal = [] : no upper bound
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