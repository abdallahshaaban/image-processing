function [Endpoints ,ShortRidges] = ExtractLandmarks(InputImage,RidgeLen)

mask = ones(3,3);
mask=[2  2  2;
	  2  50 2;
	  2  2  2];
%{
mask(1,1)=2;
mask(1,2)=2;
mask(1,3)=2;
mask(2,1)=2;
mask(2,2)=50;
mask(2,3)=2;
mask(3,1)=2;
mask(3,2)=2;
mask(3,3)=2;
%}
[H W L] = size(InputImage) ;
BW = im2bw(InputImage,.002);
ShortRidges=ones(2,2);
result1 = ones(1,2);
loopy = H-3;
loopx = W-3;

for y=1 : loopy
	for x=1:loopx
     tmp = 0;   
		for j=0:2
			for w = 0:2
				tmp =tmp+ (BW(y+j,x+w)*mask(j+1,w+1));
			
            end
        end

		if(tmp == 14)
            tmp;
			result1=[result1;y x];
        end
		
    end
end
Endpoints=result1;





