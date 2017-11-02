function [FixedSheet, xTrans, yTrans]= FixTrans(ModelSheet, TransSheet)
[h w l]=size (ModelSheet);
if (l > 1)
ModelSheet = rgb2gray(ModelSheet);
end
	[h w l ] = size (TransSheet);
	if (l>1)
	TransSheet = rgb2gray (TransSheet);
end
ftforModelSheet = fft2(ModelSheet);
ftforTransSheet=fft2(TransSheet);
%ftforModelSheet=fftshift(ftforModelSheet);
%ftforTransSheet=fftshift(ftforTransSheet);
conje=conj(ftforModelSheet);

%ftforModelSheet=double(ftforModelSheet);
conje=double(conje);
an=ftforTransSheet .* conje;
absu=abs(an);

	
ans=an ./ absu;
%ans=uint8(ans);

iff=ifft2(ans);
maxv=0;
row0=0;
col0=0;
[Row Col] = size(iff);
for i=1:Row
	for j=1:Col
		if (iff(i,j)> maxv	)
			maxv=iff(i,j);
			col0=j;
			row0=i;
		end
	end
end

if(col0 > Col/2) col0=col0-Col;end
if(row0 > Row/2) row0=row0-Row;end
xTrans = -1*col0;
yTrans = -1*row0;
FixedSheet=Trans(TransSheet,xTrans,yTrans);
imshow(FixedSheet);
end