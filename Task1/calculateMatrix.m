function result = calculateMatrix(Image, scaleOnX, scaleOnY, RotateAngle , ShearOnX,ShearOnY)
[H W L] = size(Image) ;

% Create new buffer
%scale matrix
RotateAngle = degtorad(RotateAngle);
scaleOnX =scaleOnX/W;
scaleOnY=scaleOnY/H;
Scalematrix=[scaleOnY 0 0; 0 scaleOnX 0; 0 0 1 ];
Rotatematrix=[cos(RotateAngle) sin(RotateAngle) 0;-sin(RotateAngle) cos(RotateAngle) 0; 0 0 1];
%Rotatematrix=[1 0 0 ; 0 cos(RotateAngle) -sin(RotateAngle) ;0 sin(RotateAngle) cos(RotateAngle)];

ShearY=[1 ShearOnY 0; 0 1 0; 0 0 1];
ShearX=[1 0 0; ShearOnX 1 0; 0 0 1];

result=ShearX*ShearY*Scalematrix*Rotatematrix;

end