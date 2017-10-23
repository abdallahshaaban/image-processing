function Result = IsEndPoint(Endpoints,Coordinates)
[H W] = size(Endpoints);
Result = false(1);
for i=2 : H
    if(Endpoints(i,1) == Coordinates(1,1) && Endpoints(i,2) == Coordinates(1,2))
        Result = true(1);
        break;
    end
end
end

