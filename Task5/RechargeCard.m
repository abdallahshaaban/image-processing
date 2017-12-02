function [Vendor, RegionOfNumbers] = RechargeCard(Image) 

Vendor=Identify_Card_Vendor(Image);
I=Image;
I = rgb2gray(I);
BW = im2bw(I,0.84);
figure , imshow(BW);
BW=imfill(BW,'holes');

figure , imshow(BW);
BW = bwareaopen(BW, 900);

figure , imshow(BW);
Regions = regionprops(BW, 'BoundingBox', 'Area' );

if( Regions(1).Area < Regions(2).Area)
rectangle('Position',Regions(1).BoundingBox,'edgecolor','g','linewidth',2);
RegionOfNumbers = imcrop(I, Regions(1).BoundingBox);

else
rectangle('Position',Regions(2).BoundingBox,'edgecolor','g','linewidth',2);
RegionOfNumbers = imcrop(I, Regions(2).BoundingBox);

end

end 
