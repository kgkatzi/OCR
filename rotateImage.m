function y = rotateImage(x, angle)
% figure    %used for report
% subplot(1,2,1)
% imshow(x)
% title("Initial image")
x=rgb2gray(x);
%rotation array with the angle found in findRotationAngle function
 rot=[cosd(angle) -sind(angle) 0; sind(angle) cosd(angle) 0; 0 0 1];
 %get the array ready 
  rot=affine2d(rot);
  %apply rotation
[img,~] = imwarp(x, rot);
% imshow(img)   %used for report
% title("Image 13: Point text1rot.png gets")
%ready to crop the black pixels around the actual image
[row_indices, col_indices] = find(img);
row_range=row_indices(1):row_indices(length(row_indices));
col_range=col_indices(1):col_indices(length(col_indices));
% Extract the area of interest from the image
area = img(row_range, col_range);
% Define the new grid
[xq, yq] = meshgrid(1:0.5:size(area,2), 1:0.5:size(area,1));
%nterpolate to the new size
y=interp2(double(area),xq,yq);
y=uint8(y);
% subplot(1,2,2)    %used for report
% imshow(y)
% % title("After rotation /with 0 rotation angle")   
% title("After rotation /with 30 rotation angle")
% % sgtitle("Image 2")    
% sgtitle("Image 3")
end