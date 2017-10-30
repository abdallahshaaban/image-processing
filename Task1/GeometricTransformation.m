function result = GeometricTransformation(Image,M)
[H W L] = size(Image) ;
RightUpCorner = round(M * [1;W;1]);
leftUpCorner = round(M * [1;1;1]);
LeftDownCorner = round(M * [H;1;1]);
RightDownCorner = round(M * [H;W;1]);
MinX = min([RightUpCorner(2,1) leftUpCorner(2,1) LeftDownCorner(2,1) RightDownCorner(2,1)]);
MaxX = max([RightUpCorner(2,1) leftUpCorner(2,1) LeftDownCorner(2,1) RightDownCorner(2,1)]);
MinY = min([RightUpCorner(1,1) leftUpCorner(1,1) LeftDownCorner(1,1) RightDownCorner(1,1)]);
MaxY = max([RightUpCorner(1,1) leftUpCorner(1,1) LeftDownCorner(1,1) RightDownCorner(1,1)]);
NewH = abs(MaxY - MinY);
NewW = abs(MaxX - MinX);
result = uint8(zeros(NewH, NewW, L));
for i=1:H
    for j=1:W
        NewPoint = round(M * [i;j;1]) + [-MinY;-MinX;0];
        if(NewPoint(1,1)<=NewH && NewPoint(1,1)>=1 && NewPoint(2,1)<=NewW && NewPoint(2,1)>=1)
                result(NewPoint(1,1) , NewPoint(2,1) , :) = Image(i,j,:);
        end
    end
end
end