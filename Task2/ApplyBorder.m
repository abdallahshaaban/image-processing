function  Result  = ApplyBorder(Image , Border)
[H W L] = size(Image);
for i = 1 : L
    Result(:,:,i) = max(Image(:,:,i) , Border(:,:,1));
end
end

