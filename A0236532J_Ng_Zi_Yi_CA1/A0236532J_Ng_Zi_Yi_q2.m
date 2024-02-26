% Load the image
test2 = imread('test2.bmp');

% Initialize arrays to store statistics
a_values = 0.5:0.1:1.5;
m_values = zeros(size(a_values));
mu2_values = zeros(size(a_values));
mu3_values = zeros(size(a_values));

% Loop through different values of 'a'
for i = 1:numel(a_values)
    a = a_values(i);
    
    % Call the 'enh' function
    [Iout, m, mu2, mu3] = enh('test2.bmp', a, 0);
    
    % Store the statistics
    m_values(i) = m;
    mu2_values(i) = mu2;
    mu3_values(i) = mu3;
end

% Plot m, mu2, and mu3 against a
figure;
subplot(3, 1, 1);
plot(a_values, m_values);
xlabel('a');
ylabel('Mean (m)');
title('Mean vs. a');

subplot(3, 1, 2);
plot(a_values, mu2_values);
xlabel('a');
ylabel('Mu2');
title('Mu2 vs. a');

subplot(3, 1, 3);
plot(a_values, mu3_values);
xlabel('a');
ylabel('Mu3');
title('Mu3 vs. a');
