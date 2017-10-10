function Result = Contrast( Image , NewMin , NewMax )
[RedOldMin RedOldMax] = ChannelMaxAndMin(Image(:,:,1));
[GreenOldMin GreenOldMax] = ChannelMaxAndMin(Image(:,:,2));
[BlueOldMin BlueOldMax] = ChannelMaxAndMin(Image(:,:,3));
NewRedChannel = ApplyNewRange(Image(:,:,1) , NewMin , NewMax , RedOldMin , RedOldMax);
NewGreenChannel = ApplyNewRange(Image(:,:,2), NewMin , NewMax , GreenOldMin , GreenOldMax);
NewBlueChannel = ApplyNewRange(Image(:,:,3), NewMin , NewMax , BlueOldMin , BlueOldMax);
Result(:,:,1) = NewRedChannel;
Result(:,:,2) = NewGreenChannel;
Result(:,:,3) = NewBlueChannel;
end

