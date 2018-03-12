function [stackM,kx,kz] = getMirroredStack(stack,s)

[Nx,~,Nz] = size(stack);

% compute real space
x = linspace(-Nx*s.optics.dx/2,Nx*s.optics.dx/2,Nx);
z = linspace(-Nz*s.optics.dz/2,Nz*s.optics.dz/2,Nz);

temp = stack;
if s.proc.mirrorZ
    t = temp;
    t(:,:,end+1:2*end) = temp(:,:,end:-1:1);
    temp = t;
    kz = 2*pi/(max(z)-min(z)).*linspace(-Nz/2,(Nz-1)/2,2*Nz);
else
    if mod(Nz,2) % i.e. if Nz is odd
        kz = 2*pi/(max(z)-min(z)).*linspace(-Nz/2,Nz/2,Nz);
    else
        kz = 2*pi/(max(z)-min(z)).*linspace(-Nz/2,Nz/2-1,Nz);
    end
end

if s.proc.mirrorX
    t = temp;
    t(end+1:2*end,:,:) = temp(end:-1:1,:,:);
    t(:,end+1:2*end,:) = t(:,end:-1:1,:);
    temp = t;
    kx = 2*pi/(max(x)-min(x)).*linspace(-Nx/2,(Nx-1)/2,2*Nx);
else
    if mod(Nz,2) % i.e. if Nx is odd
        kx = 2*pi/(max(x)-min(x)).*linspace(-Nx/2,Nx/2,Nx);
    else
        kx = 2*pi/(max(x)-min(x)).*linspace(-Nx/2,Nx/2-1,Nx);
    end
end

stackM = temp;
end