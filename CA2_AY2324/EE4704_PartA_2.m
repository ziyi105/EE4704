I = imread('letter.bmp');
edgeImage = edge(I, 'Sobel');

% Define resolution for r and theta
res_theta = 0.1; % Theta resolution
res_r = 0.5; % r resolution

theta = -pi/2:res_theta:pi/2;
maxRho = sqrt(size(I, 1)^2 + size(I, 2)^2); % Maximum possible value of rho
rho = -maxRho:res_r:maxRho;

% Initialize accumulator matrix
accumulator = zeros(length(rho), length(theta));

% Find edge points coordinates
[x_coords, y_coords] = find(edgeImage);
Points = [x_coords, y_coords];

% Loop through each edge point
for i = 1:numel(x_coords)
    x = x_coords(i);
    y = y_coords(i);
    
    % Calculate rho for each theta
    for j = 1:length(theta)
        r = x * cos(theta(j)) + y * sin(theta(j));
        
        % Find closest rho value in the rho array
        [~, rhoIndex] = min(abs(rho - r));
        
        % Increment accumulator
        accumulator(rhoIndex, j) = accumulator(rhoIndex, j) + 1;
    end
end

% Find the top N accumulator values
N = 13;
[top_values, top_indices] = maxk(accumulator(:), N);

% Get the corresponding rho and theta values for the top indices
[top_rho_indices, top_theta_indices] = ind2sub(size(accumulator), top_indices);
top_rho_values = rho(top_rho_indices);
top_theta_values = theta(top_theta_indices);

figure; 
% Part A Q3 a
%imshow(I)
hold on;
plot(Points(:,2), Points(:,1), '*');


for i = 1:N
    r = top_rho_values(i);
    th = top_theta_values(i);
    x0 = 1;
    y0 = (r - x0 * cos(th)) / sin(th);
    x1 = size(I, 2);
    y1 = (r - x1 * cos(th)) / sin(th);

    % Plot the lines
    plot([y0, y1], [x0, x1], 'LineWidth', 1);
end

title('Detected Lines using Hough Transform');
xlabel('X-axis');
ylabel('Y-axis');
legend('Edge Points', 'Detected Lines');
hold off;

