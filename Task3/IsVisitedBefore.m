function Result = IsVisitedBefore(ShortRidges , Coordinates)

[H W L] = size(ShortRidges);
Result = false(1);
for i=1 : H
    if(ShortRidges(i,3) == Coordinates(1,1) && ShortRidges(i,4) == Coordinates(1,2))
        Result = true(1);
        break;
    end
end
end

