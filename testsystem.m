function [rec,labels]=testsystem(d,t1,t2,t3,max1,max2,max3)

num_files=length(d);  %gets all the letters
labels = cellfun(@(x) size(x, 2), d);  %classify

 for i=1:num_files
     distance=inf;   %characterize with KNN method ,initialize distance
     if labels(i)==1
     for j=1:size(t1,1)   %see the char with the least square error
         t=t1.Var2(j);
         if norm(cell2mat(t{1})-describer(cell2mat(d{i}),max1))^2<distance
             distance=(norm(cell2mat(t{1})-describer(cell2mat(d{i}),max1))^2);
             isin=j;
             
         end

     end
     rec(i)=t1.Var1(isin);
     elseif labels(i)==2
         for jj=1:size(t2,1)
             t=t2.Var2(jj);
             if norm(cell2mat(t{1}{1})+cell2mat(t{1}{2})-describer(cell2mat(d{i}{1}),max2)-describer(cell2mat(d{i}{2}),max2))^2<distance
             distance=(norm(cell2mat(t{1}{1})+cell2mat(t{1}{2})-describer(cell2mat(d{i}{1}),max2)-describer(cell2mat(d{i}{2}),max2))^2);
             isin2=jj;
             
         end
         end
         rec(i)=t2.Var1(isin2);
     elseif labels(i)==3
         for jjj=1:size(t3,1)
             t=t3.Var2(jjj);
             if norm(cell2mat(t{1}{1})+cell2mat(t{1}{2})+cell2mat(t{1}{3})-describer(cell2mat(d{i}{1}),max3)-describer(cell2mat(d{i}{2}),max3)-describer(cell2mat(d{i}{3}),max3))^2<distance
             distance=(norm(cell2mat(t{1}{1})+cell2mat(t{1}{2})+cell2mat(t{1}{3})-describer(cell2mat(d{i}{1}),max3)-describer(cell2mat(d{i}{2}),max3)-describer(cell2mat(d{i}{3}),max3))^2);
             isin3=jjj;
             
         end
         end
         rec(i)=t3.Var1(isin3);   %all characters saved here
     end
 end
end