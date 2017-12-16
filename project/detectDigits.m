function result = detectDigits(Image) 



Im=Color(Image);
if(Im==0)


I=adaptivethreshold(Image,25,0.01);
I= bwareaopen(I,300);
se = strel('disk',1);
I = imopen(I,se);
I= bwareaopen(I,300);
Groups = ExtractRegionsOfNumbers(I);
[h w] = size(Groups);
% Extra code for testing
CC = bwconncomp(I);
bounds = regionprops(CC,'all');
for i=1 : h
    for j=1 : w
        if(Groups(i,j) == 0) 
            break;
        end
        rectangle('Position',bounds(Groups(i,j)).BoundingBox,'edgecolor','g','linewidth',2);
%         IC=imcrop(I,bounds(Groups(i,j)).BoundingBox); 
%         SE = strel('square',3);
%         IC = imerode(IC,SE);
%         IC = bwareaopen(IC, 50);
%         figure , imshow(IC);
%         CC = bwconncomp(IC);
%         CC.NumObjects
    end
end

I = 1-I ;
Groups = ExtractRegionsOfNumbers(I);
[h w] = size(Groups);
% Extra code for testing
CC = bwconncomp(I);
bounds = regionprops(CC,'all');
for i=1 : h
    for j=1 : w
        if(Groups(i,j) == 0) 
            break;
        end
        rectangle('Position',bounds(Groups(i,j)).BoundingBox,'edgecolor','g','linewidth',2);
%         IC=imcrop(I,bounds(Groups(i,j)).BoundingBox); 
%         SE = strel('square',3);
%         IC = imerode(IC,SE);
%         IC = bwareaopen(IC, 50);
%         figure , imshow(IC);
%         CC = bwconncomp(IC);
%         CC.NumObjects
    end
end



result = I ;

elseif(Im>0&&Im<6)
    result=Im;
end

end     
