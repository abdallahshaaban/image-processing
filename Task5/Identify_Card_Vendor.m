function result = Identify_Card_Vendor(Image)

[H W L] = size(Image);
img = uint8(zeros(H, W, L));

etisalat = 0;
mobinil =  0;
vodafone = 0;

for row=1:H
	for col=1:W
		if(Image(row, col, 1) >= 215 && Image(row, col, 1) <= 235 && Image(row, col, 2) >= 235 && Image(row, col, 2) <= 250 && Image(row, col, 3) >= 2 && Image(row, col, 3) <= 7)
			etisalat = etisalat + 1;
        elseif(Image(row, col, 1) >= 240 && Image(row, col, 1) <= 255 && Image(row, col, 2) >= 170 && Image(row, col, 2) <= 215 && Image(row, col, 3) >= 0 && Image(row, col, 3) <= 15)
			mobinil = mobinil + 1;
        elseif(abs(Image(row, col, 2) - Image(row, col, 3)) <= 25 && Image(row, col, 2) < 200)
			vodafone = vodafone + 1;
        end
	end
end

if(etisalat == max(etisalat, max(mobinil, vodafone)))
	result = imread('etisalat.png');
elseif(mobinil == max(etisalat, max(mobinil, vodafone)))
	result = imread('mobinil.png');
else
	result = imread('vodafone.png');;
end
end