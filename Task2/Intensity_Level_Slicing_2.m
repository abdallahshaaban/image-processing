function result = Intensity_Level_Slicing_2(Image, A, B, offset)
%UNTITLED Summary of this function goes here
%   Detailed explanation goes here

[H W L] = size(Image);
result = uint8(zeros(H, W, L));

for row=1:H
    for col=1:W
        if(Image(row, col) >= A && Image(row, col) <= col)
            result(row, col) = Image(row, col)+offset;
        else
            result(row, col) = 0;
        end
    end
end

end
