function [T, Iout] = intermeans(Iin)
    Iin = imread(Iin);
    % Initialize the threshold values
    T_prev = 0;
    T_next = mean(Iin(:));
    
    % Loop until convergence
    while abs(T_prev - T_next) > 0.5
        T_prev = T_next;
        
        % Calculate the means of two classes based on the current threshold
        class1 = Iin(Iin <= T_prev);
        class2 = Iin(Iin > T_prev);
        mean1 = mean(class1);
        mean2 = mean(class2);
        
        % Update the threshold value
        T_next = (mean1 + mean2) / 2;
    end
    
    % Final threshold value
    T = T_next;
    
    % Threshold the input image using the calculated threshold
    [rows, cols] = size(Iin);

    % Initialize the output thresholded image
    Iout = zeros(rows, cols);

    % Loop through each pixel in the image
    for i = 1:rows
        for j = 1:cols
            % Check if pixel value is greater than the threshold
            if Iin(i, j) > T
                % disp(Iin(i, j));
                % Set pixel to 1
                Iout(i, j) = 1;
            end
        end
    end

    % disp(Iout)
    % Display the input and thresholded images
    figure;
    subplot(1, 2, 1);
    imshow(Iin);
    title('Input Image', []);
    subplot(1, 2, 2);
    imshow(Iout, []);
    title(['Thresholded Image (T = ' num2str(T) ')']);
    imwrite(Iout, 'I1.bmp');
end
