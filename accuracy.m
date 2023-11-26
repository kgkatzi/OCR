function [confusion_matrix,weighted_accuracy] = accuracy(text,lines,labels)

 idx = isspace(text);
 % Remove whitespace characters
 text =(text(~idx));
  text(1)=[];
  text= string(split(text, ''));
  text(1)=[];
  text(length(text))=[];
 num_files=length(lines);
 confusion_matrix=zeros(3,2);
  for i=1:num_files
      if labels(i)==1
 if strcmp(text(i),lines(i))  %compare strings
 confusion_matrix(1,1)=confusion_matrix(1,1)+1;
 else
     confusion_matrix(1,2)=confusion_matrix(1,2)+1;
 end
      elseif labels(i)==2
          if strcmp(text(i),lines(i))
confusion_matrix(2,1)=confusion_matrix(2,1)+1;
 else
     confusion_matrix(2,2)=confusion_matrix(2,2)+1;
 end
      else
          if strcmp(text(i),lines(i))
 confusion_matrix(3,1)=confusion_matrix(3,1)+1;
 else
     confusion_matrix(3,2)=confusion_matrix(3,2)+1;
end
      end
  end

weighted_accuracy=zeros(3,1);
weighted_accuracy(1,1)=confusion_matrix(1,1)/(confusion_matrix(1,1)+confusion_matrix(1,2));
weighted_accuracy(2,1)=confusion_matrix(2,1)/(confusion_matrix(2,1)+confusion_matrix(2,2));
weighted_accuracy(3,1)=confusion_matrix(3,1)/(confusion_matrix(3,1)+confusion_matrix(3,2));


end