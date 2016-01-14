function I = AddSpecNoise(OI,v)
% This function AddSpecNoise models speckle noise in an Observed
% SAR Image.
%
% INPUT:
%          OI = Observed SAR Image
%           v = Variance
% OUTPUT:
%           I = Degraded Observed Image

if nargin<2,v = 0.04;end
if nargin<1,error('Observed SAR Image missing');end

% Add multiplicative noise to the image OI
I = imnoise(OI,'speckle',v);