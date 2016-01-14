function I = preprocess(I)
% This function preprocess the original image before performing
% processing on it.
% 
% INPUT: 
%         I = Original RGB or Gray Scale Image which has to be processed
% OUTPUT:
%         I = Output image ready for processing
% 
% Implementation starts here

[~,~,o] = size(I);  % Checking for RGB Image
if o~=1
    I = im2double(rgb2gray(I));
else
    I = im2double(I);
end