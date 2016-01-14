clear all;clc
% Get Image File from the user
 [FileName,PathName] = uigetfile(...
                             {'*.img;*.jpg;*.tif;*.png;*.gif','All Image Files';...
                             '*.*','All Files'},...
                             'Select Images','MultiSelect','off');
% % % Constructing FileName and FilePath for reading selected image
I = strcat(PathName,FileName);
RGB = read_oct_volume('P741009OS.img',512,1,1024);        % Read Selected Image
%RGB=resize(RGB,[256 512]);
%RGB = imread('baboon_nor.jpg');
OI = preprocess(RGB);   % Preprocess Seleted Image

% Get variance of noise from user
v = input('Enter variance of speckle noise = ');
NI = AddSpecNoise(OI,v);
% Applying Savitzky-Golay Filter on Noisy Image
B = sgolayfilt(NI,3,41,[],2);
% Applying Median Filter on Noisy Image
C = medfilt2(NI,[3 3]);
% Get level of wavelet decomposition from user
L = input('Enter level of wavelet decomposition = ');
% Compute Non-Decimated Two Dimensional Wavelet Transform
AI = ndwt2(OI,L,'db1');
BI = ndwt2(B,L,'db1');
CI = ndwt2(C,L,'db1');
% Applying Brute Force Threshold Algorithm for finding threshold
[threshtemp MSEtemp PSNRtemp] = bft(NI,AI,BI,CI,L,2,'try');
% Selecting best threshold value from previous BFT ouput which gives
% maximum PSNR as selecting for minimum MSE degrades the visual quality of
% image.
thresh = threshtemp(PSNRtemp==max(max(PSNRtemp)));
thresh = max(max(thresh));
% Applying Brute Force Threshold Algorithm for computing best result
[thresh MSE PSNR DI] = bft(NI,AI,BI,CI,L,2,'execute',thresh);
% Visualize Image
imwrite(ID,'.jpg');

% subplot(2,3,1);imshow(OI);title('Original Image');
% subplot(2,3,2);imshow(NI);title('Speckled Image');
% subplot(2,3,3);imshow(B);title('Savitzky-Golay Filetered Image');
% subplot(2,3,4);imshow(C);title('Median Filetered Image');
% subplot(2,3,5);imshow(DI);title('De-Speckled Image');
% xlabel(['PSNR = ',num2str(PSNR),' dB','  ','MSE = ',num2str(MSE)]);
% 
% figure(2);
% subplot(1,3,1);imshow(NI);title('Speckled Image');
% subplot(1,3,2);imshow(DI);title('De-Speckled Image');
% K=DI-NI;
% subplot(1,3,3);imshow(K);title('De-Speckled2 Image');
% xlabel(['PSNR = ',num2str(PSNR),' dB','  ','MSE = ',num2str(MSE)]);
