function c = getcontour(x)

cc = bwconncomp(~x);  %find connected compents with 0 value

b=imcomplement(x);  %complementary of the image to perform the transformations

 se = strel('square', 4);
 dilate= imdilate(b,se);   %dilated image, thicker
 % figure   used for report
% imshow(dilate)

 
con=imsubtract(dilate,b);   %substract the original from the dilated= outlines
% figure   used for report
% imshow(con)


con=bwmorph(con,'thin');  %thinner outlines
con=imcomplement(con);   %complementary again

% figure   used for report
% imshow(con)
% title("Image 9: Outline of letter e")

c = bwconncomp(~con);   %connected components of the outline= how many outlines

pr=regionprops(c,'BoundingBox');   %Extract the bounding boxes of the connected components (location of
    % outlines)

% Get pixel coordinates of each object
if numel(pr)==2   %for inner outlines   %if there are 2
    bbox= pr(2).BoundingBox;   %box that contains the inner outlines
     
    inner_outline = ones(size(con));   %we want them both on the same size
    %crop inner outline  bbox(1)=x bbox(2)=y   bbox(3)=width
    %bbox(4)=height
 inner_outline(bbox(2):bbox(2)+bbox(4)-1,bbox(1):bbox(1)+bbox(3)-1) =con(bbox(2):bbox(2)+bbox(4)-1,bbox(1):bbox(1)+bbox(3)-1);
inner_outline=logical(inner_outline);   %make it binary
outter_outline=~imsubtract(con, inner_outline);   %get outter outline by substracting the inner

[x1,y1]=find(inner_outline==0);    %find coordinates
coords1(:,1)=x1;
coords1(:,2)=y1;
[x2,y2]=find(outter_outline==0);
coords2(:,1)=x2;
coords2(:,2)=y2;
c={{coords1},{coords2}};   %save both subcells in one cell

elseif numel(pr)==3   %if there are 3 outlines
    bbox1= pr(2).BoundingBox;   %box that contains first inner outline
    %crop 1st inner outline
    inner_outline1 = ones(size(con));
    inner_outline1(bbox1(2):bbox1(2)+bbox1(4),bbox1(1):bbox1(1)+bbox1(3)) =con(bbox1(2):bbox1(2)+bbox1(4),bbox1(1):bbox1(1)+bbox1(3));

    bbox2= pr(3).BoundingBox;    %box that contains second inner outline
    %crop 2nd inner outline
    inner_outline2 = ones(size(con));
    inner_outline2(bbox2(2):bbox2(2)+bbox2(4),bbox2(1):bbox2(1)+bbox2(3)) =con(bbox2(2):bbox2(2)+bbox2(4),bbox2(1):bbox2(1)+bbox2(3));

    inner_outline1=logical(inner_outline1);
    inner_outline2=logical(inner_outline2);  %make them both binary
    outter_outline=~imsubtract((~imsubtract(con,inner_outline1)),inner_outline2)  %get the outter bu substracting them

    [x1,y1]=find(inner_outline1==0);   %get coordinates
    coords1(:,1)=x1;
    coords1(:,2)=y1;
    [x2,y2]=find(outter_outline==0);
    coords2(:,1)=x2;
    coords2(:,2)=y2;
    [x3,y3]=find(inner_outline2==0);
    coords3(:,1)=x3;
    coords3(:,2)=y3;
    c={{coords1},{coords3},{coords2}};  %save all subcells in one cell

else   %if there only is one outline

    [x,y]=find(con==0);  %get coordinates
    c1(:,1)=x;
    c1(:,2)=y;
    c={c1};  %save it one cell


end

end