function Result = AddTwoImages(FirstImage,SecondImage)
[H W L] = size(FirstImage);
SecondImage = imresize(SecondImage , [H W]);
Result = FirstImage + SecondImage;
end

