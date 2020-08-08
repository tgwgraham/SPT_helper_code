function out = gaussFilt2d(im,sig)
% convolve an 2-dimensional image with a Gaussian filter
% usage: out = gaussFilt3d(im,sigXY,sigZ)
% sigXY and sigZ are standard deviation in the XY and Z directions

[y,x] = size(im);

[X,Y] = meshgrid(linspace(-(x-1)/2,(x-1)/2,x),linspace(-(y-1)/2,(y-1)/2,y));


g = exp(-(X.*X + Y.*Y)/(2*sig^2));
g = g/sum(g(:));

out = fftshift(ifft2(conj(fft2(g)).*fft2(im)));


end