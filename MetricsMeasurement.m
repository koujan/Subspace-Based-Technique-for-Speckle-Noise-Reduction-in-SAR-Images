function [M_SE PSNR] = MetricsMeasurement(Orig_Image,Esti_Image)

% This function MetricMeasurement calculates Peak Signal-to-Noise Ratio and
% Mean-Square Error
%
% INPUTS: Orig_Image = Original Image
%         Esti_Image = Estimation of the original image obtained from a
%         noisy image after filtering it.
% OUTPUT:
%         Mean-Square Error (M_SE)
%         Peak Signal-to-Noise Ratio (PSNR)



%---Checking Input Arguments
if nargin<1||isempty(Esti_Image), error('Input Argument: Estiamted Image Missing');end

%---Implentation starts here
if (size(Orig_Image)~= size(Esti_Image)) %---Check images size
    error('Input images should be of same size');
else
    %---Mean-Square Error(MSE) Calculation
    Orig_Image = im2double(Orig_Image);%---Convert image to double class
    Esti_Image = im2double(Esti_Image);%---Convert image to double class
    [M N] = size(Orig_Image);%---Size of Original Image
    diff = Orig_Image - Esti_Image;%---Difference between two images
    M_SE = (sum(sum(diff .* diff)))/(M * N);

    %---Peak Signal-to-Noise Ratio(PSNR) Calculation 
    if(M_SE > 0)
        PSNR = 10*log10(255*255/M_SE);
    else
        PSNR = 99;
    end
end