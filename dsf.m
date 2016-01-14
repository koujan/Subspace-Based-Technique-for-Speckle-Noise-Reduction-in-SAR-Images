function I = dsf(I,ms)
% This function dsf implements Directional Smoothing Filter as
% specified in the paper entitled as Despeckling of SAR Image Using 
% Adaptive and Mean Filters, by Syed Musharaf Ali, Muhammad Younus Javed, 
% and Naveed Sarfraz Khattak
%
% INPUT:
%       I = Two Dimensional Matrix
%       ms = Window (Mask) Size
% OUTPUT:
%       I = Processed Two Dimensonal Matrix
%
% USAGE EXAMPLES:
% 
% RGB = imread('football.jpg');
% I = rgb2gray(RGB);
% NI = imnoise(I,'speckle');
% Y = dsf(I,3);
% Z3 = dsf(NI,3);
% Z5 = dsf(NI,5);
% Z7 = dsf(NI,7);
% subplot(2,3,1);imshow(I);title('Original Image');
% subplot(2,3,2);imshow(NI);title('Speckled Image');
% subplot(2,3,3);imshow(Y);title('Smooth Image of Original Image');
% subplot(2,3,4);imshow(Z3);title({'Smooth Image of Speckled Image','with window = 3X3'});
% subplot(2,3,5);imshow(Z5);title({'Smooth Image of Speckled Image','with window = 5X5'});
% subplot(2,3,6);imshow(Z7);title({'Smooth Image of Speckled Image','with window = 7X7'});

% Implemented by ASHISH MESHRAM
% meetashish85@gmail.com http://www.facebook.com/ashishmeet


% Checking Input Arguments
if nargin<2
    ms = 3;
elseif rem(ms,2)==0
    error('Mask dimension should be odd with only 3X3, 5X5, or 7X7');
elseif ms ~= 3 && ms ~= 5 && ms~= 7
    error(['Mask dimension size of ',num2str(ms),' X ',num2str(ms),...
            ' not handeled']);
end
if nargin<1,error('Input argument: Image missing');end

% Implementation starts here

[r c] = size(I);                    % Get Image dimension
PI = zeros(r + ms - 1,c + ms - 1);  % Initializing Padding Matrix
% Padding Image
PI((ms/2+0.5):end - (ms/2 - 0.5),(ms/2 + 0.5):end - (ms/2 - 0.5)) = I;

% mask = zeros(ms,ms);                % Initializing mask
% Scanning Original Image by traversing mask on it
for p = 1:r
    for q = 1:c
        mask = PI(p:ms + p - 1,q:ms + q - 1);
        % Get pixel in specified direction from mask
        if ms == 3
            % Linear Indexing for various directions on mask
            d1 = [mask(3) mask(5) mask(7)];
            d2 = [mask(4) mask(5) mask(6)];
            d3 = [mask(1) mask(5) mask(9)];
            d4 = [mask(2) mask(5) mask(8)];
        elseif ms == 5
            % Linear Indexing for various directions on mask
            d1 = [mask(5) mask(9) mask(13) mask(17) mask(21)];
            d2 = [mask(11) mask(12) mask(13) mask(14) mask(15)];
            d3 = [mask(1) mask(7) mask(13) mask(19) mask(25)];
            d4 = [mask(3) mask(8) mask(13) mask(18) mask(23)];
        elseif ms == 7
            % Linear Indexing for various directions on mask
            d1 = [mask(7) mask(13) mask(19) mask(25) mask(31) mask(37) mask(43)];
            d2 = [mask(22) mask(23) mask(24) mask(25) mask(26) mask(27) mask(28)];
            d3 = [mask(1) mask(9) mask(17) mask(25) mask(33) mask(41) mask(49)];
            d4 = [mask(4) mask(11) mask(18) mask(25) mask(32) mask(39) mask(46)];
        else
            % This situation would not be reached as we're checking it in
            % input argument itself.
            error('Situation could not be handeled');
        end
        
        % Refer the paper specified in function documentation
        v = mean([d1 d2 d3 d4]); % Computing Average of pixels of each direction
        V1 = abs(v - mask(ms/2 + 0.5,ms/2 + 0.5));
        [~,index] = min(V1);
        I(p,q) = v(index);
    end
end