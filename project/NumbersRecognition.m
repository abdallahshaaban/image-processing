function result =  NumbersRecognition( I , Image )
strings = ones(0,10)*-2; 
Groups1 = ExtractRegionsOfNumbers(I);
[h w] = size(Groups1);

% Extra code for testing
CC = bwconncomp(I);
bounds = regionprops(CC,'all');
str = ones(1,10)*-2;
a=1;
for i=1 : h
    Flag = 0;
    if(i>1 && abs(bounds(Groups1(i-1,l)).BoundingBox(2) - bounds(Groups1(i,1)).BoundingBox(2)) <= bounds(Groups1(i,1)).BoundingBox(4)/4 && abs(bounds(Groups1(i-1,l)).BoundingBox(4) - bounds(Groups1(i,1)).BoundingBox(4))<=10 )
        str(1,a) = -1;
        a = a + 1;
        Flag = 1;
    else
        str = ones(1,10)*-2;
        a=1;
    end
    l=0;
    for j=1 : w
        if(Groups1(i,j) == 0) 
            l = j-1;
            break;
        end
        rectangle('Position',bounds(Groups1(i,j)).BoundingBox,'edgecolor','g','linewidth',2);
        IC=imcrop(I,bounds(Groups1(i,j)).BoundingBox);
        IC = bwareaopen(IC, 300);
        d = NearestDigit( IC , [0 1 2 3 4 5 6 7 8 9 10]);
        if(d(1,1) > 3)
            continue;
        elseif(j == 1 && d(1,2) == 10 && a == 1)
            str(1,a) = 10;
        elseif(bounds(Groups1(i,j)).MajorAxisLength/bounds(Groups1(i,j)).MinorAxisLength >= 3)
            str(1,a) = 1;
        elseif(bounds(Groups1(i,j)).EulerNumber < 0)
            str(1,a) = 8;
        elseif(bounds(Groups1(i,j)).EulerNumber == 0)
            DL = [0 4 6 9];
            td = NearestDigit( IC , DL);
            str(1,a) = td(1,2);
        elseif(bounds(Groups1(i,j)).EulerNumber == 1)
            DL = [2 3 5 7];
            td = NearestDigit( IC , DL);
            str(1,a) = td(1,2);
        else
            td = NearestDigit( IC , [0 1 2 3 4 5 6 7 8 9]);
            str(1,a) = td(1,2);
        end
%          figure,imshow(IC);
        a = a + 1;
    end
    if Flag
        [h w] = size(strings);
        strings(h,:) = [];
    end
    strings = [strings ; str];
end
result = strings;
end

