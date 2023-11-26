 
%%%%%for b==1
 text1=imread("text1.png");
    [lines,labels]= readtext(text1,1,1);
     text=fileread('text1.txt');



% % % % % % %  %text1=imrotate(text1,30);   %how rotation was tested without rotated
% % % % % % %                                 %images
% % % % % % %  %text1=imresize(text1,[s(1) s(2)]);
% % % % % % % % angle = findRotationAngle(text1);
% % % % % % % % y = rotateImage(text1, -angle);


%%%%%%for b==2
%   text1=imread("text2.png");
%    [lines,labels]= readtext(text1,2,2);
%   text=fileread('text2.txt');


%%%%%%   %for b==3
%       text1=imread("text1.png");
%    [lines,labels]= readtext(text1,1,3);
%    text=fileread('text2.txt');


 [confusion_matrix,weighted_accuracy] = accuracy(text,lines,labels);
 disp("Confusion matrix is:  ")
     disp(confusion_matrix)
 disp("weighted_accuracy is:    ")
 disp(weighted_accuracy)


