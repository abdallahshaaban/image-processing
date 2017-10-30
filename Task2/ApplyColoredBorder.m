function Result = ApplyColoredBorder(Image , Border)
[H W L] = size(Image);
Result = Border;
for i=1 : H
    for j=1 : W
        if(Border(i,j,1)==255 && Border(i,j,2)==255 && Border(i,j,3)==255)
            Result(i,j,:) = Image(i,j,:);
        end
    end
end
end

