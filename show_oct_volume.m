function show_oct_volume(IV)
% showing the OCT volume given in IV, one B-scan at a time
% press a key to show another B-scan
%
% D. SIDIBE, April 8th, 2015

for i=1:size(IV,3)
    imshow(IV(:,:,i), []); title(['image n° ' num2str(i)]);
    %waitforbuttonpress;
end
