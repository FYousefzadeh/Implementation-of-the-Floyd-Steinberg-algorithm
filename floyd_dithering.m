close all;
clear;
clc;
inImg=imread('pasta.tif');
inImg=rgb2gray(inImg);
inImg = double(inImg);
[M,N] = size(inImg);
T = 127.5; %Threshold
I_hat = inImg;
error = 0;
for i = 1:M-1  
    
    %Left Boundary of Image
    I_hat_q(i,1) =255*(I_hat(i,1)>=T);
    error = -I_hat_q(i,1) + I_hat(i,1);
    I_hat(i,1+1) = 7/16 * error + I_hat(i,1+1);
    I_hat(i+1,1+1) = 1/16 * error + I_hat(i+1,1+1);
    I_hat(i+1,1) = 5/16 * error + I_hat(i+1,1);
    
    for j = 2:N-1
        %Center of Image
        I_hat_q(i,j) =255*(I_hat(i,j)>=T);
        error = -I_hat_q(i,j) + I_hat(i,j);
        I_hat(i,j+1) = 7/16 * error + I_hat(i,j+1);
        I_hat(i+1,j+1) = 1/16 * error + I_hat(i+1,j+1);
        I_hat(i+1,j) = 5/16 * error + I_hat(i+1,j);
        I_hat(i+1,j-1) = 3/16 * error + I_hat(i+1,j-1);
    end
    
    %Right Boundary of Image
    I_hat_q(i,N) =255*(I_hat(i,N)>=T);
    error = -I_hat_q(i,N) + I_hat(i,N);
    I_hat(i+1,N) = 5/16 * error + I_hat(i+1,N);
    I_hat(i+1,N-1) = 3/16 * error + I_hat(i+1,N-1);
    
end
%Bottom & Left Boundary of Image
i = M;
I_hat_q(i,1) =255*(I_hat(i,1)>=T);
error = -I_hat_q(i,1) + I_hat(i,1);
I_hat(i,1+1) = 7/16 * error + I_hat(i,1+1);
%Bottom & Center of Image
for j = 2:N-1
    I_hat_q(i,j) =255*(I_hat(i,j)>=T);
    error = -I_hat_q(i,j) + I_hat(i,j);
    I_hat(i,j+1) = 7/16 * error + I_hat(i,j+1);
end
%Thresholding
I_hat_q(i,N)=255*(I_hat(i,N)>=T);
I_hat_q_b=im2bw(uint8(I_hat_q));
figure();
imshow(I_hat_q_b);title('Pasta with Floyd Filter');

