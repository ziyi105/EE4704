function [r, theta] = rtheta(Iin)
    edgeImage = imread(Iin);
   
    % Calculate centroid
    [y_coords, x_coords] = find(edgeImage == 255);
    centroid_x = mean(x_coords);
    centroid_y = mean(y_coords);

    % Calculate theta and rho (distance from centroid)
    numPoints = length(x_coords);
    theta = zeros(1, numPoints);
    rho = zeros(1, numPoints);

    % Display the image with the centroid marked
    figure;
    imshow(edgeImage);
    hold on;
    plot(centroid_y, centroid_x, 'r+', 'MarkerSize', 10);
    title('Boundary Image with Centroid');
    hold off;
    
    for i = 1:numPoints
        x = x_coords(i);
        y = y_coords(i);
        theta_deg = atan2d(y - centroid_y, x - centroid_x);

        if theta_deg < 0 
            theta_deg = theta_deg + 360;
        end

        theta_deg = theta_deg - 360;
        theta_deg = abs(theta_deg);

        theta(i) = theta_deg;
        rho(i) = sqrt((x - centroid_x)^2 + (y - centroid_y)^2);
    end
    
    % Plot graph of rho vs theta
    figure;
    plot(theta, rho, '.');
    title('Rho vs Theta');
    xlabel('Theta (degrees)');
    ylabel('Rho');

    r = rho;
end
