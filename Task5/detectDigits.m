
 function result = detectDigits(Image) 
 
 
 

 
 
 I=adaptivethreshold(Image,25,0.05);
 I=~I;
 figure,imshow(I);
  se = strel('disk',1);

 I= imerode(I,se);

 
 CC = bwconncomp(I);
 bounds = regionprops(CC,'all');
 z=size(bounds);
 for i=1:size(bounds)
   
     width = bounds(i).BoundingBox(3);
    height= bounds(i).BoundingBox(4);
  
     if(bounds(i).Area <500 || bounds(i).Area >=5000)
         continue;
        end;
     if( (height / width)>=5 && (height / width) <= 20)%&&bounds(i).Extent >.3&&bounds(i).FilledArea >500&&bounds(i).FilledArea <1600)
 
         IC=imcrop(Image,bounds(i).BoundingBox); 
     %    figure,imshow(IC);
     rectangle('Position',bounds(i).BoundingBox,'edgecolor','g','linewidth',2);
     end
     end
     
 
 
 
 
 
 
 
 result = I ;
 
 
 end   