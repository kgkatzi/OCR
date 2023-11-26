function [T1,T2,T3,max1,max2,max3]= mapletters(d,a)
    max3=0;   %initialize because there may bo no letters with 3 outlines
    d=d(1:round(0.7*length(d)));   %seperate data space, 70% will be fo training
    num_files=length(d);   %new number of letters
    if a==1    %which font 
     text = fileread('text1.txt');
    else
        text = fileread('text2.txt');
    end
    
 % Find indices of whitespace characters
idx = isspace(text);
% Remove whitespace characters
text =(text(~idx));
 text(1)=[];
 text= string(split(text, ''));
 text(1)=[];
 text(length(text))=[];
 text=text(1:round(0.7*length(text)));

    % Get the labels for the data  %classify
labels = cellfun(@(x) size(x, 2), d);
for i=1:num_files  %for every letter
    if labels(i)==1  %check class
        s1(i)=size(cell2mat(d{i}),1);   %get all sizes of the coordinates of each class
    elseif labels(i)==2
        cell1=d{i}{1};
        cell2=d{i}{2};
        s2_1(i)=size(cell2mat(cell1),1);
        s2_2(i)=size(cell2mat(cell2),1);
    else
        cell1=d{i}{1};
        cell2=d{i}{2};
        cell3=d{i}{3};
        s3_1(i)=size(cell2mat(cell1),1);
        s3_2(i)=size(cell2mat(cell2),1);
        s3_3(i)=size(cell2mat(cell3),1);
    end
end
sizes1=nonzeros(s1);  % not needed
sizes2_1=nonzeros(s2_1);
sizes2_2=nonzeros(s2_2);
if exist('s3_1','var')   %if there is at least one letter with 3 outlines
 sizes3_1=nonzeros(s3_1);
 sizes3_2=nonzeros(s3_2);
 sizes3_3=nonzeros(s3_3);
 max3_1=max(sizes3_1);
 max3_2=max(sizes3_2);
 max3_3=max(sizes3_3);
 max3half=max(max3_1,max3_2);
 max3=max(max3half,max3_3);
end
max1=max(sizes1);   %find the maximum size for every class, it will be used in describer function 
% to make them all the same size so that they can be compared
max2_1=max(sizes2_1);
max2_2=max(sizes2_2);
max2=max(max2_1,max2_2);
 k1=1;
 k2=1;
 k3=1;
for i=1:num_files
    if labels(i)==1
        d1{k1}={describer(cell2mat(d{i}),max1)};   %get describers of first class, saved in variable d1
        t1(k1)=text(i);   %corresonding letter of the actual text saved in variable t1
       k1=k1+1;
        
    elseif labels(i)==2   %same for other classes
        
        d2{k2}{1}={describer(cell2mat(d{i}{1}),max2)};
        d2{k2}{2}={describer(cell2mat(d{i}{2}),max2)};
        t2(k2)=text(i);
       k2=k2+1;
        
     elseif labels(i)==3
         d3{k3}{1}={describer(cell2mat(d{i}{1}),max3)};
         d3{k3}{2}={describer(cell2mat(d{i}{2}),max3)};
         d3{k3}{3}={describer(cell2mat(d{i}{3}),max3)};
         t3(k3)=text(i);
         k3=k3+1;
    end
end


 %Create table with all them
 T1 = table(t1',d1');
 T2 = table(t2',d2');
 if a~=2
  T3 = table(t3',d3');
  else
      T3=[];
  end

end