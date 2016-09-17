A=imread('user002_1.gif');
B=double(A);

W = 16;
Theta = 0;
blcD = zeros(ceil(size(B,1)/W),ceil(size(B,2)/W));

M=zeros(size(B,1),size(B,2));
N=zeros(size(B,1),size(B,2));


 for i=1:W:size(B,1);
    for j=1:W:size(B,2);
        if j+W-1 < size(B,2) & i+W-1 < size(B,1)
        %Sobel mask for x-direction:
        Gx=((2*B(i+2,j+1)+B(i+2,j)+B(i+2,j+2))-(2*B(i,j+1)+B(i,j)+B(i,j+2)));
        %Sobel mask for y-direction:
        Gy=((2*B(i+1,j+2)+B(i,j+2)+B(i+2,j+2))-(2*B(i+1,j)+B(i,j)+B(i+2,j)));
        m=Gx.*Gy;
        n=(Gx-Gy).*(Gx+Gy);
		M = sum(sum(m(i:i+W-1, j:j+W-1)));
        N = sum(sum(n(i:i+W-1, j:j+W-1)));          
        Theta = 0;  
%         if minus_value ~= 0 & times_value ~=0             
        twiceTheta = atan2(2*M,N);
        Theta = (twiceTheta)/2 ;
        Theta = Theta+pi/2;     
            %theta is within [0,pi]
        blcD(ceil(i/W),ceil(j/W)) = Theta;
%         end
        end
    end
end


figure,imshow(A); title('Sobel gradient');

Thresh=100;
A=max(A,Thresh);
A(A==round(Thresh))=0;

A=uint8(A);
figure,imshow(~A);title('Edge detected Image');
