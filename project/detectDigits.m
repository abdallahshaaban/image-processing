function result = detectDigits(Image) 



Im=Color(Image);
if(Im==0)


I=adaptivethreshold(Image,25,0.01);
I= bwareaopen(I,300);
se = strel('disk',1);
I = imopen(I,se);
I= bwareaopen(I,300);

CC = bwconncomp(I);
bounds = regionprops(CC,'all');
z=size(bounds);
for i=1:size(bounds)
    
    width = bounds(i).BoundingBox(3);
    height= bounds(i).BoundingBox(4);
    
    if(bounds(i).Area <500 || bounds(i).Area >=1500 || height <=30 || height >=100 || width <=30 || width >=110)
        continue;
    end;
    
    if( (height / width)>=1 && (height / width) <= 3&&bounds(i).Extent >.3&&bounds(i).FilledArea >500&&bounds(i).FilledArea <1600)

        IC=imcrop(Image,bounds(i).BoundingBox); 
    %    figure,imshow(IC);
    rectangle('Position',bounds(i).BoundingBox,'edgecolor','g','linewidth',2);
    end
    
end



I = 1-I ;
CC = bwconncomp(I);
bounds = regionprops(CC,'all');
z=size(bounds);

for i=1:size(bounds)
    
    width = bounds(i).BoundingBox(3);
    height= bounds(i).BoundingBox(4);
    
    if(bounds(i).Area < 500 || bounds(i).Area >=1500 || height <=30 || height >=100 || width <=30 || width >=110 )
        continue;
    end;
    
    if( (height / width)>=0.8 && (height / width) <= 3&&bounds(i).Extent >.3&&bounds(i).FilledArea >500&&bounds(i).FilledArea <2500)
          rectangle('Position',bounds(i).BoundingBox,'edgecolor','g','linewidth',2);
             
    end
    
end



result = I ;

elseif(Im>0&&Im<6)
    result=Im
end

end     
