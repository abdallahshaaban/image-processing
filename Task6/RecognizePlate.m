function Digits = RecognizePlate( Image )
Digits = zeros(1,0);
ExpectedH = 480;
ExpectedW = 1030;
I = rgb2gray(Image);
I = im2bw(I);
I = imresize(I , [ExpectedH ExpectedW]);
%Automatic Calculation Of the region of numbers
TI=imfill(I,'holes');
%figure , imshow(TI);
Regions = regionprops(TI, 'BoundingBox', 'Area' );
MaxI = 1;
MaxArea = -1;
for i = 1 : length(Regions)
    if( Regions(i).Area > MaxArea)
        MaxArea = Regions(i).Area;
        MaxI = i;
    end
end
RegionOfNumbers = imcrop(I, Regions(MaxI).BoundingBox);
%figure , imshow(RegionOfNumbers);
[a b] = size(RegionOfNumbers);
RegionOfNumbers = RegionOfNumbers(20:a-20,30:(b/2) - 30);
%End of Automatic Calculation Of the region of numbers

% %Manual Calculation Of the region of numbers
% RegionOfNumbers = I(190:460 , 30:485);
% % figure , imshow(RegionOfNumbers);
% %The end of Manual Calculation Of the region of numbers

RegionOfNumbers = not(RegionOfNumbers);
RegionOfNumbers = imfill(RegionOfNumbers,'holes');
%figure , imshow(RegionOfNumbers);
DigitsWithDistance = zeros(2,0);
DigitsImage = [1 3 4 6 7 8 9];
for i=1 : 7
    name = strcat(num2str(DigitsImage(:,i)),'.bmp');
    d = imread(name);
    DigitsWithDistance = [DigitsWithDistance GetDigitDistance(RegionOfNumbers , d , DigitsImage(:,i))];
end
DigitsWithDistance = sortrows(DigitsWithDistance.',2).';
Digits = DigitsWithDistance(1,:);
length(Digits)
end

