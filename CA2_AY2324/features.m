function [Per1, Area1, Com1, Cen1, InvMoment1] = features(Iin)
    binary_img = imbinarize(imread(Iin));
    
    stats = regionprops(binary_img, 'Perimeter', 'Area', 'Centroid');

    % Extract the perimeter, area, and centroid of the object
    Perimeter = stats.Perimeter;
    Area = sum(binary_img(:) ~= 0);
    Centroid = stats.Centroid;
    Compactness = (Perimeter^2) / (4 * pi * Area);
        
    % Calculate first invariant moment (ϕ1)
    [rows, cols] = size(Iin);
    [X, Y] = meshgrid(1:cols, 1:rows);
    X = double(X) - Centroid(1);
    Y = double(Y) - Centroid(2);
    InvMoment1 = sum(sum((X.^2 + Y.^2) .* double(Iin)));

    Per1 = Perimeter;
    Area1 = Area;
    Com1 = Compactness;
    Cen1 = Centroid;
end
