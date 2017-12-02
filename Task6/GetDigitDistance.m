function Result = GetDigitDistance( Image , dImage , digit)
Result = zeros(2,0);
I = rgb2gray(dImage);
I = im2bw(I);
I = not(I);
I = imfill(I,'holes');
SE = strel('square',5);
I = imerode(I , SE);
M = imerode(Image,strel(I));
%figure , imshow(I);
M = sum(M);
flag = 0;
for i=1 : length(M)
    if flag == 0 && M(:,i)>0
        flag=1;
        Result = [Result [digit;i]];
    elseif M(:,i) == 0
        flag=0;
    end    
end
end