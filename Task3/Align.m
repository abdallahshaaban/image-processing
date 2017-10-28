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

background = Image(1,1,:);

Minr = 10000;
Maxr = -1 ;
Minc = 10000;
Maxc = -1 ;

for row=1:H
    for col=1:W
        if(Image(row,col,:)== background)
            continue ;
        end
        if(row < Minr)
             Minr =row ;
             P(:, 2) = [row;col;1];
        end  
         if(row>Maxr)
             Maxr=row;
             P(:, 3) = [row;col;1];
             
         end
             
         if(col<Minc)
             Minc = col ;
              P(:, 1) = [row;col;1];
         end
             
          if(col>Maxc)
             Maxc = col ;
             P(:,4) = [row;col;1];
          end
    end
end

AlignedImage = Warp(Image,P,Q);
Corners = P;

end

