% Author : Adrien Descloux
% Date : 04 March 2018
% Version : 2.0

% Map the variable val from the range [valMin valMax] to 
% the range [mapMin mapMax]
function  rsc = linmap(val,valMin,valMax,mapMin,mapMax)

% convert the input value between 0 and 1
tempVal = (val-valMin)./(valMax-valMin);

% clamp the value between 0 and 1
map0 = tempVal < 0; map1 = tempVal > 1;
tempVal(map0) = 0; tempVal(map1) = 1;

% rescale and return
rsc = tempVal.*(mapMax-mapMin) + mapMin;

end