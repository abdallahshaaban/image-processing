function [Result C]= GetNextCoordinates(InputImage , CurrCoordinates , PrevCoordinates)
[H W] = size(InputImage);
i = CurrCoordinates(1,1);
j = CurrCoordinates(1,2);
pi = PrevCoordinates(1,1);
pj = PrevCoordinates(1,2);
Result = int16.empty(0,2);
C=0;
if(i-1>=1 && ~(i-1 == pi && j == pj) && InputImage(i-1,j)==0) 
    Result = [Result;i-1 j];
    C=C+1;
end
if(i+1<=H && ~(i+1 == pi && j == pj) && InputImage(i+1,j)==0) 
    Result = [Result;i+1 j];
    C=C+1;
end
if(j-1>=1 && ~(i == pi && j-1 == pj) && InputImage(i,j-1)==0) 
    Result = [Result;i j-1];
    C=C+1;
end
if(j+1<=W && ~(i == pi && j+1 == pj) && InputImage(i,j+1)==0) 
    Result = [Result;i j+1];
    C=C+1;
end
if(i-1>=1 && j-1>=1 && ~(i-1 == pi && j-1 == pj) && InputImage(i-1,j-1)==0) 
    Result = [Result;i-1 j-1];
    C=C+1;
end
if(i+1<=H && j-1>=1 && ~(i+1 == pi && j-1 == pj) && InputImage(i+1,j-1)==0) 
    Result = [Result;i+1 j-1];
    C=C+1;
end
if(i-1>=1 && j+1<=W && ~(i-1 == pi && j+1 == pj) && InputImage(i-1,j+1)==0) 
    Result = [Result;i-1 j+1];
    C=C+1;
end
if(i+1<=H && j+1<=W && ~(i+1 == pi && j+1 == pj) && InputImage(i+1,j+1)==0) 
    Result = [Result;i+1 j+1];
    C=C+1;
end
end

