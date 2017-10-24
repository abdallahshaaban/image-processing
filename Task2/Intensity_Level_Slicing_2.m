function result = Intensity_Level_Slicing_2(Image, A, B, value)
%UNTITLED Summary of this function goes here
%   Detailed explanation goes here

[H W L] = size(Image);
result = uint8(zeros(H, W, L));

for row=1:H
    for col=1:W
        if(Image(row, col) >= A && Image(row, col) <= B)
            result(row, col) = Image(row, col)+value;
        else
            result(row, col) = 0;
        end
    end
end

end
