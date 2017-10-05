function result = GeometricTransformation(image, NewWidth, NewHight, RotateAngle , ShearOnX,ShearOnY)
[H W L] = size(image) ;

% Create new buffer
%scale matrix
NewWidth =NewWidth/W;
NewHight=NewHight/H;
Scalematrix=[NewWidth 0 0; 0 NewHight 0; 0 0 1 ];
Rotatematrix=[cos(RotateAngle) -sin(RotateAngle) 0;sin(RotateAngle) cos(RotateAngle) 0; 0 0 1];
%Rotatematrix=[1 0 0 ; 0 cos(RotateAngle) -sin(RotateAngle) ;0 sin(RotateAngle) cos(RotateAngle)];

ShearX=[1 ShearOnX 0; 0 1 0; 0 0 1];
ShearY=[1 0 0; ShearOnY 1 0; 0 0 1];

Ww=ShearX*ShearY*Scalematrix*Rotatematrix;

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