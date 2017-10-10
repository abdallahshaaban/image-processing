function Result = ApplyNewRange( Image , NewMin , NewMax , OldMin , OldMax )
Result = uint8((double(Image - OldMin)/double(OldMax - OldMin)) * (NewMax - NewMin) + NewMin);
end


