function [data]= getletters(x,a)  %a variable declares the font
    angle = findRotationAngle(x);   %call function to find rotation angle
    y=rotateImage(x,-angle);    %rotate the image if necessary
    data = [];     %initialize data variable
    m=1;   %this variable is used to save every letter of every word of every line on the data output
    brightness_projection = sum(y, 2);    %projection on veritcal axis
    
    % Smooth the brightness projection with a moving average filter
    if a~=2
    window_size = 20;
    else
        window_size=12;
    end
    brightness_projection_smoothed = movmean(brightness_projection, window_size);
  
    % Threshold the smoothed brightness projection
    %for text1 or letters png this is the ideal threshold (training)
    if a~=2
    threshold = 0.99 * max(brightness_projection_smoothed);
    %text2 needs another threshold
    else
        threshold = 0.98 * max(brightness_projection_smoothed);
    end
    %get the brightness projection that is above the threshold
    %this is the location that contains the lines
    %binary because I only need to seperate the pixels containing lines
    %from the ones that dont
    binary_image = brightness_projection_smoothed > threshold;
   
    % Find the connected components in the binary image (lines)
    cc = bwconncomp(~binary_image);
    % Extract the bounding boxes of the connected components (location of
    % lines)
    props = regionprops(cc, 'BoundingBox');
   
 for i = 1:length(props) %loop to get all the lines one by one
     %from now on we are working on lines
    % Extract the bounding box (location) of the current line
    bbox = props(i).BoundingBox;
     % Crop the line image to the bounding box
     %bbox(2)=y   bbox(4)=height
    line_image = y(bbox(2):bbox(2)+bbox(4),:);

%     figure     %used for report
%     imshow(line_image)
%     title("Image 10: Line image")

    %morphological operation to make the image better
    se = strel('disk', 1);
    line_image_opened = imopen(line_image, se);
     % Compute the brightness projection along the horizontal axis  so that
     % i can find the words
    brightness_projection_lines = sum(line_image_opened, 1);
   %smooth the projection with moving average filter
     window_size2 = 15;
    brightness_projection_smoothed_lines = movmean(brightness_projection_lines, window_size2);
  
     % Threshold the brightness projection to seperate the word containing
     % pixels from the ones that dont
     if a~=2
    threshold_lines = 0.96 * max(brightness_projection_smoothed_lines);
     else
           threshold_lines = 0.98 * max(brightness_projection_smoothed_lines);
     end
    binary_image_lines= brightness_projection_smoothed_lines > threshold_lines;
  
     % Find the connected components in the binary image (words)
    cc_lines = bwconncomp(~binary_image_lines);
    
    % Extract the bounding boxes of the connected components (locations of
    % words
    props_words = regionprops(cc_lines, 'BoundingBox');

   for j=1:length(props_words)    %loop to get all the words one by one
       %from now on we are working on words

      % Extract the bounding box (location) of the current word
      wordbox = props_words(j).BoundingBox;
       % Crop the word image to the bounding box
       %wordbox(1)=x        wordbox(3)=width
      word_image = line_image(:,wordbox(1):wordbox(1)+wordbox(3));

% figure    %used for report
% imshow(word_image)
% title("Image 11: Word image")
      

  %this binirizing threshold is used to get rid of some other things the
  %word image contains (like underlines)
  %at least to the point where they dont prevent me from seperating lines
  word_image=imbinarize(word_image,0.35);
  

     % Compute the brightness projection along the vertical axis
    brightness_projection_word = sum(word_image, 1);
    % Smooth the brightness projection with a moving average filter
    
    window_size_word = 2;
    
    brightness_projection_smoothed_word = movmean(brightness_projection_word, window_size_word);
    
    % Threshold the smoothed brightness projection
    %seperate pixels that contain letters from the ones thad don't
    if a~=2
    threshold_word = 0.973 * max(brightness_projection_smoothed_word);
    
    else
        threshold_word = 0.99999999 * max(brightness_projection_word);
    end
    binary_image_word = brightness_projection_smoothed_word > threshold_word;
   
    % Find the connected components in the binary image
    cc_word = bwconncomp(~binary_image_word);
    
    % Extract the bounding boxes of the connected components (letters)
    props_letters = regionprops(cc_word, 'BoundingBox');
   
    for k = 1:length(props_letters)   %loop to get all the letters one by one
          % Crop the letter image to the bounding box
         letterbox = props_letters(k).BoundingBox;
     
         %crop the letter image
         %letterbox(1)=x    letterbox(3)=width
        letter_image=word_image(:,letterbox(1):letterbox(1)+letterbox(3)-1);

%         figure     %used for report
%         imshow(letter_image)
%         title("Image 12: Letter image")

        %this is used to add some white pixels around the image so that the
        %outline can be found and not stopped by the letter image
        %dimentions
        padded_image = padarray(letter_image, [2, 2], 255, 'both');

        %calling function to get outlines of the letter
        %this function returns a cell with the coordinates
        %as many cells as the number of outlines
        %if there are more than one cell the function returns a cell
        %containing these subcells
        con=getcontour(padded_image);
        
        %save the cell coordinates of each letter of the text image
        data{m}=con;
         m=m+1;   %increase
    end
    
     
   end

 end
if a==1
data(1296)=[]; %for text1 because the cursor is saved as a letter in my training data
end

end