function result = Warp( Image , P , Q )

[H W L] = size(Image);

WW =( Q * P.') * inv(P * P.');

Minr = min(Q(1,:));
Maxr = max(Q(1,:));
Minc = min(Q(2,:));
Maxc = max(Q(2,:));

HW = Maxr - Minr;
Dw = Maxc - Minc;

result = uint8(ones(round(HW)+5,round(Dw)+5, 3)) ;

for	row=1:1000
	for col=1:1000
        if(row>=Minr && row<= Maxr && col>= Minc && col <=Maxc )                              
             Q= inv(WW) * [row;col;1];
             Q=round(Q);
             oldX = Q(1,1);
             oldY = Q(2,1);
             if(1<=oldX && oldX<=H && 1<=oldY && oldY<=W)
             result(row,col,:)=Image(oldX,oldY,:);
             end
        end
    end
end

