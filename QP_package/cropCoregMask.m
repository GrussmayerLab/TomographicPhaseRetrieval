function stack = cropCoregMask(stack)

    temp = stack ~= 0;
    mask = sum(temp,3); mask = (mask == 8); 
    masky = (sum(mask,2)./Nx > 0.5);
    [~,ay] = max(masky); [~,by] = max(masky(end:-1:1)); by = length(masky)-by+1;
    maskx = (sum(mask,1)./Nx > 0.5);
    [~,ax] = max(maskx); [~,bx] = max(maskx(end:-1:1)); bx = length(maskx)-bx+1;
    temp_nPix = min(bx-ax+1,by-ay+1);
    stack = stack(ay:temp_nPix-1+ay,ax:temp_nPix+ax-1,:);