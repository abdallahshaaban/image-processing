function [ Result ] = ImageThresholding(Image)
[H W L] = size(Image);
Result = uint8(zeros(H,W,L));
for i=1 : H
    for j=1 : W
        for k=1 : L
            if(Image(i,j,k)>=100)
                Result(i,j,k)=255;
            end
        end
    end
end
end

