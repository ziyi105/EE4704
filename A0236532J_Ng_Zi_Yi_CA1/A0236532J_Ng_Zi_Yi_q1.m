% Load the image
img = imread('test1.bmp');

% Open the image in imtool
imtool(img);

% Define the start and end points of the profile line
x1 = 88;
y1 = 141;
x2 = 283;
y2 = 171;

% Extract the intensity profile along the line
profile_data = improfile(img, [x1, x2], [y1, y2]);
% 
% Plot the intensity profile
plot(profile_data);
xlabel('Distance along the profile');
ylabel('Intensity');
title('Intensity Profile');

% Generate the histogram
histogram = imhist(img);

% Plot the histogram
figure;
bar(histogram);
title('Image Histogram');
xlabel('Pixel Intensity');
ylabel('Frequency');

% Perform histogram equalization
equalized_img = histeq(img);

% Display the original and equalized images side by side
figure;
subplot(1, 2, 1);
imshow(img);
title('Original Image');

subplot(1, 2, 2);
imshow(equalized_img);
title('Equalized Image');

% Optionally, save the equalized image
imwrite(equalized_img, 'equalized_image.jpg');