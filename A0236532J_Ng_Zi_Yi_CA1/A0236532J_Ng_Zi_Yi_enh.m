% To enhance an image using the transformation s_k = a*(r_k + b).
% Inputs: the uint8 matrix of the gray level image 'xxx.bmp', and the parameters a, b.
% Outputs: the figure showing the input and output images with their respective histograms,
% the message to indicate clipping, and the histogram features m, mu2, mu3.
function [Iout, m, mu2, mu3] = enh(Iin, a, b)   
    % Open image
    img = imread(Iin);

    % Apply the transformation
    Iout = a * (double(img) + b);

    % Determine clipping
    clipping_0 = any(Iout(:) < 0);
    clipping_255 = any(Iout(:) > 255);
    
    % Clip values below 0 to 0 and above 255 to 255
    Iout(Iout < 0) = 0;
    Iout(Iout > 255) = 255;
    
    % Compute image statistics
    m = mean(Iout(:));
    mu2 = mean((Iout(:) - m).^2);
    mu3 = mean((Iout(:) - m).^3);   
    
    if clipping_0 && clipping_255
        clipping_msg = 'Clipping at both 0 and 255.';
    elseif clipping_0
        clipping_msg = 'Clipping at 0.';
    elseif clipping_255
        clipping_msg = 'Clipping at 255.';
    else
        clipping_msg = 'No clipping.';
    end
    
    % Create the figure with subplots
    figure;
    
    % % Input Image and Input Histogram
    % subplot(2, 2, 1);
    % imshow(img);
    % title('Input Image');
    % 
    % subplot(2, 2, 3);
    % imhist(uint8(img));
    % title('Input Histogram');
    
    % Output Image and Output Histogram
    subplot(2, 1, 1);
    imshow(uint8(Iout));
    title('Output Image');
    
    subplot(2, 1, 2);
    imhist(uint8(Iout));
    title('Output Histogram');
    
    % Display statistics and clipping message
    fprintf('Mean (m): %.2f\n', m);
    fprintf('Mu2: %.2f\n', mu2);
    fprintf('Mu3: %.2f\n', mu3);
    fprintf('%s\n', clipping_msg);
end
