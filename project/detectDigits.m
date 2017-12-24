function [result strings] = detectDigits(Image) 


strings = ones(0,10)*-2; 
Im=Color(Image);
if(Im==0)

I=adaptivethreshold(Image,25,0.01);
%I= bwareaopen(I,300);
se = strel('disk',1);
I = imopen(I,se);
% I= bwareaopen(I,300);
strings = NumbersRecognition(I , Image);
I = 1-I ;
strings = [strings ; NumbersRecognition(I , Image)];
result = I ;

elseif(Im>0&&Im<6)
    result=Im;
end

end     
