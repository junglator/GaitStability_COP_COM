function val = median_values(data)
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
    % Calculate the median values of data within specified intervals.
    %
    % Usage:
    %   val = median_value(data)
    %
    % Inputs:
    %   data: Array of numerical data.
    %
    % Outputs:
    %   val: Array of median values for each interval.
    %
    % Author:
    %   Aditya Srivastava
    %   srivastavaadi177@gmail.com
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

    % Define the size of each interval
    interval = 500;
    
    % Calculate the number of full intervals
    num_intervals = floor(length(data) / interval);

    % Preallocate the array to store the median values of each interval
    val = zeros(1, num_intervals);

    % Calculate the median for each interval
    for i = 1:num_intervals
        start_index = (i - 1) * interval + 1;
        end_index = i * interval;
        val(i) = median(data(start_index:end_index));
    end

    % Handle the remainder of the data that doesn't fit into a full interval
    remainder = mod(length(data), interval);
    if remainder ~= 0
        remaining_data = data(end - remainder + 1:end);
        remaining_median = median(remaining_data);
        val = [val, remaining_median];
    end
end
