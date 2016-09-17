A=imread('user001_1.gif');
B=double(A);
[a b]=size(B);

Sob=[-1 -2 -1;0 0 0;1 2 1];
Gra_twotimes=zeros(a,b);
Gra_sq_minus=zeros(a,b);
Gx=filter2(Sob,image);
Gy=filter2(Sob',image);
Gra_twotimes=Gx.*Gy;
Gra_sq_minus=(Gx-Gy).*(Gx+Gy);

D=4;
BlcDirection=zeros(a/D,b/D);


for i=1:D:a;
    for j=1:D:b;
        while j+D-1 > a & i+D-1 > b;
             times_value=0;
             minus_value=0;
             times_value = sum(sum(Gra_twotimes(i:i+D-1, j:j+D-1)));
             minus_value = sum(sum(Gra_sq_minus(i:i+D-1, j:j+D-1)));          
             theta = 0;
             twiceTheta = atan2(2*times_value,minus_value);
             theta = (twiceTheta)/2;
             theta = theta+pi/2;
             BlcDirection(i/D,j/D) = theta;
        end;
    end;
end;

directionField=zeros(a,b);
for i=1:ceil(a/D);
    for j=1:ceil(b/D);
        directionField((i-1)*D+1:i*D,(j-1)*D+1:j*D)=blockDirection(i,j);
    end;
end;
directionField=directionField(1:a,1:b);

drawOrientation(A,directionField);