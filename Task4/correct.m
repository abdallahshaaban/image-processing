function ans =correct (image , image1 )

image = im2bw (image);
image1 =im2bw(image1);

dif = image-image1;
figure,imshow(dif);
[H W]=size (dif);
cont=0;
for x=2:H-1
	for y =2:W-1
		if(dif(x,y)==0&&dif(x+1,y)==1&&dif(x,y+1)==1&&dif(x-1,y)==1&&dif(x,y-1)==1)
			cont = cont +1;
		end  

	end 
end 
ans = cont ;
ans


		