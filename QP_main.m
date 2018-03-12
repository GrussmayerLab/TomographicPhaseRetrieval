%% This file contains a basic pipeline for QP retrieval from brightfield stacks
% - 3D image stack loading
% - 3D stack preprocessing
% - processing parameters definition
% - phase retrival
% - display of the results

addpath('QP_package')
%% 3D image stack loading
[stack,pname,fname] = loadData;
[Nx,Ny,Nz] = size(stack);

%% 3D stack preprocessing 
if Nz == 8 % i.e. multiplane data : remove the coregistration mask
    stack = cropCoregMask(stack); 
    stack = cropXY(stack,temp_nPix-4); % extra safety crop 
else
    stack = cropXY(stack); %% crop the stack to have a square image
end
    [Nx,Ny,Nz] = size(stack);
    
%% Phase retrieval
% define optics and processing parameters
run('setup_phase.m');

% set experimental parameters
if size(stack,3) == 8 % i.e. MultiPlane data
    s.optics.dz = 0.35; % [um]
else
    s.optics.dz = 0.2; % typical sampling for fixed cells
end

% compute the phase
QP = getQP(stack,s);

% custom 3D stack plotting 
plotStack(QP)