clear;
close all
% Read Image and Convert to Grey Scale
scale = 1;
I_rgb = imread('image_0_92','png');
I_grey = double(rgb2gray(imresize(I_rgb,scale)));
[I_m, I_n] = size(I_grey);

% Smooth the Image
% H_smooth = fspecial('gaussian',[3,3],2);
% I_grey = imfilter(I_grey, H_smooth);

% Define Sobel Filter and Get horizontal and vertical gradient
H_sobel = fspecial('sobel');
I_x = conv2(I_grey,H_sobel','same'); % 'corr' gives edge direction of increasing intensity
I_y = conv2(I_grey,H_sobel,'same'); 

% Compute Contrast Normalized Sobel Filter
numerator_x = sqrt(2)*I_x;
numerator_y = sqrt(2)*I_y;
esp = 1;
LP_filter = [1 2 1;2 4 2;1 2 1];
denominator = sqrt(16*conv2(I_grey.^2,LP_filter,'same') - (conv2(I_grey,LP_filter,'same')).^2 + eps^2);
C_x = numerator_x./denominator;
C_y = numerator_y./denominator;

C(:,:,1) = C_x;
C(:,:,2) = C_y;
% Define unit vectors on unit circle: K
% Reference: 
r = 5;
[K_x, K_y, num_K] = compute_K(r);
K(:,:,1) = K_x;
K(:,:,2) = K_y;
% Compute Affinity Matrix
Ar = compute_Ar(r, C, K, num_K);
% figure;subplot(2,1,1);imshow(I_grey,[]);
% subplot(2,1,2);
subplot(1,2,1);mesh(Ar(178-2*r:178+2*r,552-2*r:552+2*r)');
%subplot(1,2,2);mesh(Ar(126-2*r:126+2*r,717-2*r:717+2*r)');
subplot(1,2,2);mesh(Ar(229-2*r:229+2*r,367-2*r:367+2*r)');
%figure;imshow(zeros(size(I_grey)),[]);hold on; quiver(C_x, C_y)


% find all detected circles with threshold = 0.7
idx_detection = find(Ar>=0.7);

for idx = 1:length(idx_detection)
    lin_idx = idx_detection(idx);
    [i,j] = ind2sub(size(Ar),lin_idx);
    if i>=(2*r+1) && i<= (I_m-2*r-1) && j>=(2*r+1) && j<=(I_n-2*r-1)
        figure;mesh(Ar(i-2*r:i+2*r,j-2*r:j+2*r)');
    end;
end;


























