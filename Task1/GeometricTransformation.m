function result = GeometricTransformation(image,Ww)
[H W L] = size(image) ;

A=[1 1 1]*Ww;
B=[1 W 1]*Ww;
C=[H 1 1]*Ww;
D=[H W 1]*Ww;

maxx=max(max(A(1,1),D(1,1)),max(B(1,1),C(1,1)));

minx=min(min(A(1,1),D(1,1)),min(B(1,1),C(1,1)));

Newx=maxx-minx;

maxy=max(max(A(1,2),D(1,2)),max(B(1,2),C(1,2)));

miny=min(min(A(1,2),D(1,2)),min(B(1,2),C(1,2)));

Newy=maxy-miny;
result = uint8(zeros(round(Newy)+5,round(Newx)+5, L));
size(result)
T = [- round(minx), - round(miny),0] ;
% Apply the translation (pixel by pixel)
for	y=1:H
	for x=1:W
		Q=[y x 1]* Ww;
		Q=round(Q);
		Q=Q+T;

		result(Q(1,1) +1, Q(1,2)+1 , :)=image(y ,x,:);
end
end