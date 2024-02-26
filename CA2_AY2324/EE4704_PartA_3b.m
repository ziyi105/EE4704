I = imread('letter.bmp');
edgeImage = edge(I, 'Sobel');

% Display the original image and the edge image
figure;
subplot(1, 2, 1);
imshow(I);
title('Original Image');

subplot(1, 2, 2);
imshow(edgeImage);
title('Edge Image');

res_a = 0.1;
res_b = 0.1;
a = -1:res_a:3;
b = -300:res_b:1500;

% Find the coordinates where the pixel values are equal to 1
[x_coords, y_coords] = find(edgeImage == 1);
Points = [x_coords, y_coords];

coordinatesDict = containers.Map('KeyType', 'char', 'ValueType', 'any');
my_accumulator = zeros(length(a),length(b));

for i = 1:size(Points,1)
    tmp_b = -1 * Points(i,1) * a + Points(i,2);
    for k = 1:length(tmp_b)
        [closest_b, closest_b_index] = min(abs(tmp_b(k) - b));
        
        if closest_b <= 0.5 * res_b
            % Store the coordinates in the dictionary for the respective (a, b) combination
            key = sprintf('a_%.2f_b_%.2f', a(k), b(closest_b_index));
            if isKey(coordinatesDict, key)
                coordinatesDict(key) = [coordinatesDict(key); Points(i, :)];
            else
                coordinatesDict(key) = [Points(i, :)];
            end

            my_accumulator(k, closest_b_index) = my_accumulator(k, closest_b_index) + 1;
        end
    end
end

figure;
imshow(I);
hold on;

[top_values, top_index] = maxk(my_accumulator(:), 17);

final_params = [];
for j = 1 : length(top_index)
    [tmp_row, tmp_col] = ind2sub([length(a), length(b)], top_index(j));
    final_params = [final_params; a(tmp_row), b(tmp_col)];    

    key = sprintf('a_%.2f_b_%.2f', final_params(1), final_params(2));
    lineCoordinates = coordinatesDict(key);
    plot(lineCoordinates(:, 2), lineCoordinates(:, 1), 'LineWidth', 2);
end

hold off;
