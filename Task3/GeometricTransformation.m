function result = GeometricTransformation(image, WW)
[H W L] = size(image) ;


A=WW*[1;1;1];
B=WW*[H;1;1];
C=WW*[1;W;1];
D=WW*[H;W;1];

maxx=max(max(A(1,1),D(1,1)),max(B(1,1),C(1,1)));
minx=min(min(A(1,1),D(1,1)),min(B(1,1),C(1,1)));

Dw=maxx-minx;

maxy=max(max(A(2,1),D(2,1)),max(B(2,1),C(2,1)));
miny=min(min(A(2,1),D(2,1)),min(B(2,1),C(2,1)));

HW=maxy-miny;

result = uint8(ones(round(HW)+5,round(Dw)+5, 3)) ;

WW(1,3) = WW(1,3) + - round(minx) ;
WW(2,3) = WW(2,3) + - round(miny) ;

for	row=1:HW
	for col=1:Dw
        Q= inv(WW) * [row;col;1];
        Q=round(Q);
        oldX = Q(1,1)+1;
        oldY = Q(2,1)+1;
        if(1<=oldX && oldX<=HW && 1<=oldY && oldY<=Dw)
            result(row,col,:)=image(oldX,oldY,:);
        
        end
	end
end

