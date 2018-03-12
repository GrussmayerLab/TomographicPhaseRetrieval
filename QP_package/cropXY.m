% This function crop the input 3D stack to have the size [N,N,~]
% if N > than Nx or Ny, it make sure that the resulting image is square
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

