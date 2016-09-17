A=imread('user001_1.gif');
image=double(A);
w=16;
[Nn Mm]=size(image);           %图片大小
blockDirection = zeros(ceil(Nn/w),ceil(Mm/w));
h=[-1 -2 -1;0 0 0;1 2 1];      %Sobel 算子
Gx=filter2(h,image);           %得梯度向量的Gx分量  
Gy=filter2(h',image);          %得梯度向量的Gy分量
gradient_times_value = zeros(Nn,Mm);
gradient_sq_minus_value = zeros(Nn,Mm);
gradient_times_value=Gx.*Gy;
gradient_sq_minus_value=(Gx-Gy).*(Gx+Gy);

for i=1:w:Nn;                      %计算边缘方向
    for j=1:w:Mm;
      if j+w-1 < Nn & i+w-1 < Mm
          times_value = sum(sum(gradient_times_value(i:i+w-1, j:j+w-1)));
          minus_value = sum(sum(gradient_sq_minus_value(i:i+w-1, j:j+w-1)));          
          theta = 0;  
%         if minus_value ~= 0 & times_value ~=0             
            twiceTheta = atan2(2*times_value,minus_value);
            theta = (twiceTheta)/2 ;
            theta = theta+pi/2;     
            %theta is within [0,pi]
            blockDirection(ceil(i/w),ceil(j/w)) = theta;
      end;
    times_value = 0;
    minus_value = 0;
    end;
end;

directionField=zeros(Nn,Mm);
for i=1:ceil(Nn/w)
    for j=1:ceil(Mm/w)
        directionField((i-1)*w+1:i*w,(j-1)*w+1:j*w)=blockDirection(i,j);
    end
end
directionField=directionField(1:Nn,1:Mm);


drawOrientation(image,directionField);