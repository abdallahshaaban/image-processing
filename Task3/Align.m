function [AlignedImage, Corners] = Align( Image, Dw, HW)
%UNTITLED2 Summary of this function goes here
%   Detailed explanation goes here

%3*4 matrix of the four markers on the 1st image
P = ones(3, 4);

%3*4 matrix of the corresponding points on the 2ed image
Q = [1 1 HW HW;
    1 Dw 1 Dw;
    1 1 1 1];

[H W L] = size(Image);

for row=1:H
    for col=1:W
        if(Image(row, col, 2) == 0 && Image(row, col, 3) == 0 && Image(row, col, 1) == 224)
            P(:, 2) = [row;col;1];
        elseif(Image(row, col, 1) == 0 && Image(row, col, 2) == 0 && Image(row, col, 3) >= 200)
            P(:, 4) = [row;col;1];
        elseif(Image(row, col, 1) == 0 && Image(row, col, 3) == 0 && Image(row, col, 2) >= 200)
            P(:, 3) = [row;col;1];
        elseif(Image(row, col, 3) == 0 && Image(row, col, 2) == 0 && Image(row, col, 1) == 243)
            P(:, 1) = [row;col;1];
        end
    end
end

%calculating the transformation matrix
WW =( Q * P.') * inv(P * P.');

result = uint8(ones(round(HW)+5,round(Dw)+5, 3)) * 255;

for	row=1:H
	for col=1:W
        Q= WW * [row;col;1];
        Q=round(Q);
        oldX = Q(1,1)+1;
        oldY = Q(2,1)+1;
        if(1<=oldX && oldX<=HW && 1<=oldY && oldY<=Dw)
            result(oldX,oldY,:)=Image(row,col,:);
        
        end
	end
end

AlignedImage = result ;
Corners = P ;

end

