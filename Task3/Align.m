function [AlignedImage, Corners] = Align( Image, Dw, HW)
%UNTITLED2 Summary of this function goes here
%   Detailed explanation goes here

%3*4 matrix of the four markers on the 1st image
P = ones(3, 4);

%3*4 matrix of the corresponding points on the 2ed image
%Q = [Dw 1 Dw 1; 1 1 HW HW; 1 1 1 1];
Q = [1 Dw 1 Dw; 1 1 HW HW; 1 1 1 1];

[H W L] = size(Image);



for row=1:H
    for col=1:W
        if(Image(row, col, 2) == 0 && Image(row, col, 3) == 0 && Image(row, col, 1) == 224)
            P(:, 2) = [col; row; 1];
            %disp(Image(row, col, :));
        elseif(Image(row, col, 1) == 0 && Image(row, col, 2) == 0 && Image(row, col, 3) >= 200)
            P(:, 4) = [col; row; 1];
            %disp(Image(row, col, :));
        elseif(Image(row, col, 1) == 0 && Image(row, col, 3) == 0 && Image(row, col, 2) >= 200)
            P(:, 3) = [col; row; 1];
            %disp(Image(row, col, :));
        elseif(Image(row, col, 3) == 0 && Image(row, col, 2) == 0 && Image(row, col, 1) == 243)
            P(:, 1) = [col; row; 1];
            %disp(Image(row, col, :));
        end
    end
end


%calculating the transformation matrix
WW = Q * P.' * inv(P * P.');



AlignedImage = GeometricTransformation(Image, WW);
Corners = Q;




end

