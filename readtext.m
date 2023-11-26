function [lines,labels] = readtext(x,a,b)
data= getletters(x,a);   %get coordinates of every letter
 [T1,T2,T3,max1,max2,max3]=mapletters(data,a);    %get mapping tables

if b==3   %if we want to test text2 on system trained on text1
  t=imread("text2.png")   
  tt=getletters(t,2);
 [lines,labels]=testsystem(tt,T1,T2,T3,max1,max2,max3);
else %if not, we test each text on the one that it was trained on

%test and get text
[lines,labels]=testsystem(data,T1,T2,T3,max1,max2,max3);
end
disp("Text is: ")
disp(join(lines))
end