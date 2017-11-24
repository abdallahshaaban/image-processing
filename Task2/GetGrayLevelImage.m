function Result = GetGrayLevelImage( Image )
%Average
% Result = (Image(:,:,1)+Image(:,:,2)+Image(:,:,3))/3;
%luminosity
Result = (0.2989 * Image(:,:,1) + 0.5870 * Image(:,:,2) + 0.1140 * Image(:,:,3));
end

