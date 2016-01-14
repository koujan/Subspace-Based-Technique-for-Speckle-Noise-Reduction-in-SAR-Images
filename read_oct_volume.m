function [oct_volume] = read_oct_volume(iname, X, Y, Z)
% read the OCT volume stored in the file iname (here *.img)
% X, Y and Z are the images parameters
% in our case: X = 512, Y= 128, Z = 1024; means each volume contains 128
% B-scan, each of dimension X=512 and Z=1024
% the intensity value of each pixel is stored as unsigned 8-bit
%
% D. SIDIBE, April 8th, 2015

oct_volume = zeros(Z, X, Y);
fin = fopen(iname,'r');
for i=1:Y
    I = fread(fin, [X,Z],'ubit8=>uint8'); 
    oct_volume(:, :, i) = imrotate(I, 90);
end
fclose(fin);

