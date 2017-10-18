function result = GeometricTransformation(image, Ww)
[H W L] = size(image) ;


A=[1 1 1]*Ww;
B=[W 1 1]*Ww;
C=[1 H 1]*Ww;
D=[W H 1]*Ww;


maxx=max(max(A(1,1),D(1,1)),max(B(1,1),C(1,1)));

minx=min(min(A(1,1),D(1,1)),min(B(1,1),C(1,1)));

Newx=maxx-minx;

maxy=max(max(A(1,2),D(1,2)),max(B(1,2),C(1,2)));

miny=min(min(A(1,2),D(1,2)),min(B(1,2),C(1,2)));

Newy=maxy-miny;
result = uint8(zeros(round(Newy)+5,round(Newx)+5, L));
size(result)
T = [- round(minx), - round(miny),0] ;

P = [16 168 133 283; 70 14 337 282; 1 1 1 1];

% Apply the translation (pixel by pixel)
for	y=1:H
	for x=1:W
        Q=[x y 1]* Ww;
        Q=round(Q);
        Q=Q+T;
        result(Q(1,2) +1, Q(1, 1)+1 , :)=image(y ,x,:);
	end
end
%Apply the reverse mapping
Ww(1, 3) = T(1, 1);
Ww(2, 3) = T(1, 2);
Ww(3, 3) = 1;

Winv = inv(Ww);

[h w l] = size(result);

for	y=1:h
	for x=1:w        
        Q=[x y 1] * Winv;
        Q=round(Q);
        oldX = Q(1,1)+1;
        oldY = Q(1, 2)+1;
        if(1<=oldX && oldX<=W && 1<=oldY && oldY<=H)
            result(y, x, :)=image(oldY, oldX,:);
        else
            result(y, x, :)=[0 0 0];
        end
	end
end
