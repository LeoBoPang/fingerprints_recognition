A=imread('user001_1.gif');      %read the image in
B=double(A);                    %transfer to double foramt
[a,b] = size(B);                %calculate the width and height

Gra_twotimes = zeros(a,b);      
Gra_sq_minus = zeros(a,b);      %create new metrixes for storing data
Sob = [-1 -2 -1;0 0 0;1 2 1];   
Gx = filter2(Sob,B);
Gy = filter2(Sob',B);           %calculate the Gx and Gy metrix
Gra_twotimes=Gx.*Gy;
Gra_sq_minus=(Gx-Gy).*(Gx+Gy);  %as the equation required

D = 8;                          %constant for block processing
BlcDirection = zeros(ceil(a/D),ceil(b/D));         %create a new metrix for storing direction values

for i=1:D:a
    for j=1:D:b
      if j+D-1 < b & i+D-1 < a
          times_value = 0;
          minus_value = 0;
		  times_value = sum(sum(Gra_twotimes(i:i+D-1, j:j+D-1)));      %calculate the sum of Gx
          minus_value = sum(sum(Gra_sq_minus(i:i+D-1, j:j+D-1)));      %calculate the sum of Gy
          theta = 0;
          twiceTheta = atan2(2*times_value,minus_value);               %as the equation required
          theta = (twiceTheta)/2 ;                                     
          theta = theta+pi/2;                                          %obtain the theta
          BlcDirection(ceil(i/D),ceil(j/D)) = theta;                   %store the data into a metrix
      end      
    end
end

DirField=zeros(a,b);
for i=1:ceil(a/D)
    for j=1:ceil(b/D)
        DirField((i-1)*D+1:i*D,(j-1)*D+1:j*D)=BlcDirection(i,j);
    end
end
DirField=DirField(1:a,1:b);                                %store the direction data into this metrix

drawOrientation(A,DirField);                                     %call the function to draw directions

