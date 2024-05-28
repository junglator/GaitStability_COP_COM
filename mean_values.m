function val = mean_values(data)
    % Calculate the mean values of data in intervals
    %
    % Inputs:
    %   data: Numeric array of data points
    %
    % Outputs:
    %   val: Array of mean values calculated for each interval
    %
    % Author:
    %   Aditya Srivastava
    %   Email: srivastavaadi177@gmail.com
    
    % Interval size
    interval = 500;
    % Number of complete intervals
    num_intervals = floor(length(data) / interval);
    
    % Preallocate the array for means
    val = zeros(1, num_intervals);
    
    % Calculate mean for each interval
    for i = 1:num_intervals
        start_index = (i - 1) * interval + 1;
        end_index = i * interval;
        val(i) = mean(data(start_index:end_index));
    end
    
    % Handle the remainder of the data that doesn't fit into an interval
    remainder = mod(length(data), interval);
    if remainder ~= 0
        remaining_data = data(end - remainder + 1:end);
        remaining_mean = mean(remaining_data);
        val = [val, remaining_mean];
    end    
end