function d =describer(c,max)   %inputs coordinates and maximim size of every class

 if(length(c)<max)   %this is used instead of interp1, to make all the describers of each class the same size, so that they can be compared later
     
     c(length(c)+1:max,1)=0;  
     c(length(c)+1:max,2)=0;
 
 end

r=complex(c(:,1), c(:,2));  %make the coordinates complex

d=fft2(r);   %dft of complex array
d(1)=[];  %without the first value

end