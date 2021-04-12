clc
clear
close all

img = imread('cameraman.tif');
[M, N] = size(img);

%% 1. for original histogram
original_hist = imhist(img);
original_CDF = cumsum(original_hist)/(M*N);

original_eq = img;
for k = 0:255
    original_eq(img==k) = 255*original_CDF(k+1);
end

%% 2. for bins histogram
number_of_bins = 64;
bins_histogram = imhist(img, number_of_bins);

x = 1:256/number_of_bins:256;
xq = 1:256;
interpolate_hist = interp1(x, bins_histogram, xq);
interpolate_CDF = cumsum(interpolate_hist)/(M*N*256/number_of_bins);

interpolate_eq = img;
for k = 0:255
    interpolate_eq(img==k) = 255*interpolate_CDF(k+1);
end

%% show results
figure(1);
subplot(3,3,1); imshow(img); title('input image');

subplot(3,3,4); bar(xq, original_hist); title('original histogram');
subplot(3,3,5); bar(xq, original_CDF); title('original CDF');
subplot(3,3,6); imshow(original_eq); title('result for original CDF');

subplot(3,3,7); bar(xq, interpolate_hist); title('bins histogram');
subplot(3,3,8); bar(xq, interpolate_CDF); title('bins CDF');
subplot(3,3,9); imshow(interpolate_eq); title('result for bins CDF');

