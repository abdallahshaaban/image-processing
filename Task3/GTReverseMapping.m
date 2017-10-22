function result = GTReverseMapping(image, Ww)
[H W L] = size(image);

A=[1 1 1]*Ww;
B=[W 1 1]*Ww;
C=[1 H 1]*Ww;
D=[W H 1]*Ww;


maxx=max(max(A(1,1),D(1,1)),max(B(1,1),C(1,1)));

minx=min(min(A(1,1),D(1,1)),min(B(1,1),C(1,1)));

NewW=maxx-minx;

maxy=max(max(A(1,2),D(1,2)),max(B(1,2),C(1,2)));

miny=min(min(A(1,2),D(1,2)),min(B(1,2),C(1,2)));

NewH=maxy-miny;
result = uint8(zeros(round(NewH, 0),round(NewW, 0), L));
T = [- round(minx), - round(miny),0] ;

%Apply the reverse mapping
Winv = inv(Ww);

Winv(1, 3) = T(1, 1);
Winv(2, 3) = T(1, 2);
Winv(3, 3) = 1;

[h w l] = size(result);

for	y=1:h
	for x=1:w        
        Q = Winv * [x; y; 1];
        Q = round(Q);
        oldX = Q(1,1);
        oldY = Q(2, 1);
        if(1<=oldX && oldX<=W && 1<=oldY && oldY<=H)
            result(y, x, :)=image(oldY, oldX,:);
        else
            result(y, x, :)=[0 0 0];
        end
	end
end
