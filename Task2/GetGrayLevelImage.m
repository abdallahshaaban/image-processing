function Result = GetGrayLevelImage( Image )
Result = (Image(:,:,1)+Image(:,:,2)+Image(:,:,3))/3;
end

