function Result = Gamma(Image,Gamma)
Temp=double(Image).^Gamma;
Result = Contrast(Temp,0,255);
end

