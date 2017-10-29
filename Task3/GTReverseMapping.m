function result = GTReverseMapping( Image , M )
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
M(1,3)=-MinY;
M(2,3)=-MinX;
M(3,3) = 1;
M=inv(M);
for i=1:NewH
    for j=1:NewW
        NewPoint = round(M * [i;j;1]);
        if(NewPoint(1,1)<=H && NewPoint(1,1)>=1 && NewPoint(2,1)<=W && NewPoint(2,1)>=1)
                result(i , j , :) = Image(NewPoint(1,1),NewPoint(2,1),:);
        end
    end
end
end