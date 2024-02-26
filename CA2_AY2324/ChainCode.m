function [my_code] = ChainCode(Iin)
    % Read the input image
    edgeImage = imread(Iin);
        
    % Find the starting point for the object boundary
    [start_y, start_x] = find(edgeImage == 255, 1);
    [y, x] = find(edgeImage == 255);
    Points = [y, x];
    
    % Initialize variables clockwise direction
    directions = [0, 1; -1, 1; -1, 0; -1, -1; 0, -1; 1, -1; 1, 0; 1, 1]; % 8-connectivity
    dir = -1; 
    current_x = start_x;
    current_y = start_y;
    chaincode = [];

    % Chain code calculation
    for i = 1:size(Points, 1)
        for j = 1:8
            new_x = current_x + directions(j, 2);
            new_y = current_y + directions(j, 1);
            if edgeImage(new_y, new_x) == 255 && j~= mod(dir + 4, 8)
                % Store the chain code
                chaincode = [chaincode, j-1];
                current_x = new_x;
                current_y = new_y;
                dir = j; 
                break;
            end
        end
    end
    
    % Iterate through the array to find the longest zero chain
    current_length = -1;
    current_start_index = -1;
    max_length = -1;
    start_index = -1;

    for j = 1:length(chaincode)
        if chaincode(j) == 0
            % If the current element is zero, increment the length of the current zero chain
            if current_length == 0
                % Update the starting index of the current zero chain
                current_start_index = j;
            end
            current_length = current_length + 1;
            
            % Check if the current zero chain is longer than the previous longest chain
            if current_length > max_length
                max_length = current_length;
                start_index = current_start_index;
            end
        % if multiple max_lengths are found, check the subsequence non-zero integer
        elseif current_length == max_length && start_index ~= j - max_length && start_index ~= -1
            curr_index = start_index + max_length;
            i = j;
            while i < length(chaincode) && chaincode(i) == chaincode(curr_index)
                i = j + 1;
                curr_index = curr_index + 1;                
            end
            % If the chain ends or a smaller following integer is found
            if i == length(chaincode) || chaincode(i) < chaincode(curr_index)
                start_index = i - max_length;
            end
            current_length = 0;
        else
            % If the current element is non-zero, reset the length of the current zero chain
            current_length = 0;
        end
    end

    my_code = circshift(chaincode, -start_index + 1);
end
