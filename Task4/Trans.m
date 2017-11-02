function FixedSheet= Trans(ModelSheet, col0,row0)
[H W ] = size(ModelSheet) ;
imshow(ModelSheet)
FixedSheet = uint8(ones(H,W));

% Apply the translation (pixel by pixel)
col0=col0+1;
row0=row0+1;
for	y=1:H %row
	for x=1:W %col
		nrow = y+row0;
		ncol = x+col0;

	if(nrow < 1 )
		nrow = nrow + H;
	end 
	if(nrow > H )
		nrow = nrow - H;
	end 
	if (ncol < 1)
		ncol = ncol +W;
	end 
	if (ncol > W)
		ncol = ncol -W;
	end 
	FixedSheet(nrow , ncol ) = ModelSheet(y , x );
		
end
end
