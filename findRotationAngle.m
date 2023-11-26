 function angle = findRotationAngle(x)
     x_gray=rgb2gray(x);
     blurred_img=imgaussfilt(x_gray,5);%blur the image to connect the line letters
%      figure
%      imshow(blurred_img)   %used for report
    dft = fft2(blurred_img);   
    mag_dft =abs(dft);    %norm of fourier transform

 [max_mag, max_idx] = max(sum((mag_dft),1));   %maximim projection of fourier norm on the horizontal axis
 [max_freq_y, max_freq_x] = ind2sub(size(mag_dft), max_idx);   %create an array with this maximum values

est_angle = atan2(max_freq_y, max_freq_x) * 180 / pi;   %first estimation of angle
best_angle = est_angle;    %initialize, this will find the best angle
best_goodness_of_fit = -inf;     %initialize
for angle = est_angle - 45: est_angle + 45   %serial search around the angle estimation
    % Undo the rotation 
    unrotated_img = imrotate(blurred_img, -angle, 'bilinear', 'crop');
    % Compute the projection of the brightness on the vertical axis.
    projection = sum(unrotated_img, 2);
    % Compute the goodness of fit between the projection and the actual brightness values.
    goodness_of_fit = sum((projection - mag_dft).^2);
    % Update the best angle if the current angle is better.
    if goodness_of_fit > best_goodness_of_fit
        best_angle = angle;
        best_goodness_of_fit = goodness_of_fit;
    end
end
angle = best_angle

end
