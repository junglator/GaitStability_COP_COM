function main
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
    % This script is analyze distance data for different sets of participants, days, and activities.
    % It calculates the mean and standard deviation of the distance data, combines statistics across 
    % all participants, days, and activities, and displays the results based on specific participant groups.
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%    
    % Author: Aditya Srivastava
    % Email: srivastavaadi177@gmail.com
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
    clear all; clc;
    % Load the data for processing 
    dataprocess;

    % Create Struct for storing mean and standard deviations
    mean_struct = {};
    std_struct = {};

    % Define participants, days, activities, and sample sizes
    participants_sets = {["CO3", "CO4", "CO5"], ["ST3", "ST4", "ST5"], ["RO1", "RO2", "RO5"]};
    days = ["Day1", "Day2"];
    activities_set = {["NW1", "NW2"], ["ZT1", "ZT2"], ["GA1", "GA2"], ["OP1", "OP2"]};
    sample_sizes = [120, 120, 120, 120, 120, 120];

    % Analyze data for each set of participants and days
    for i = 1:length(participants_sets)
        for j = 1:length(days)
            for k = 1:length(activities_set)
                participants = participants_sets{i};
                day = days(j);
                activities = activities_set{k};
                [mean_struct,std_struct] = analyze_data(distance, participants, day, activities, sample_sizes,mean_struct,std_struct);
             end
        end
    end
     % Plot the mean and std results

        CO_day1 = [mean_struct.Day1.NW2.CO, mean_struct.Day1.ZT2.CO, mean_struct.Day1.GA2.CO,NaN];
        ST_day1 = [mean_struct.Day1.NW2.ST, mean_struct.Day1.ZT2.ST, mean_struct.Day1.GA2.ST,NaN];
        RO_day1 = [mean_struct.Day1.NW2.RO, mean_struct.Day1.ZT2.RO, mean_struct.Day1.GA2.RO,NaN];
        
        CO_day2 = [mean_struct.Day2.NW2.CO, mean_struct.Day2.ZT2.CO, mean_struct.Day2.GA2.CO,mean_struct.Day2.OP2.CO];
        ST_day2 = [mean_struct.Day2.NW2.ST, mean_struct.Day2.ZT2.ST, mean_struct.Day2.GA2.ST,NaN];
        RO_day2 = [mean_struct.Day2.NW2.RO, mean_struct.Day2.ZT2.RO, mean_struct.Day2.GA2.RO,mean_struct.Day2.OP2.RO];
        
        CO_std_day1 = [std_struct.Day1.NW2.CO, std_struct.Day1.ZT2.CO, std_struct.Day1.GA2.CO,NaN];
        ST_std_day1 = [std_struct.Day1.NW2.ST, std_struct.Day1.ZT2.ST, std_struct.Day1.GA2.ST,NaN];
        RO_std_day1 = [std_struct.Day1.NW2.RO, std_struct.Day1.ZT2.RO, std_struct.Day1.GA2.RO,NaN];
                
        CO_std_day2 = [std_struct.Day2.NW2.CO, std_struct.Day2.ZT2.CO, std_struct.Day2.GA2.CO,std_struct.Day2.OP2.CO];
        ST_std_day2 = [std_struct.Day2.NW2.ST, std_struct.Day2.ZT2.ST, std_struct.Day2.GA2.ST,NaN];
        RO_std_day2 = [std_struct.Day2.NW2.RO, std_struct.Day2.ZT2.RO, std_struct.Day2.GA2.RO,std_struct.Day2.OP2.RO];
        
        % Create figure
        figure;

    % Day 1
    subplot(1, 2, 1);
    h1 = errorbar(1:4, [CO_day1; ST_day1; RO_day1], [CO_std_day1; ST_std_day1; RO_std_day1], 'o-', ...
        'MarkerSize', 8, 'MarkerFaceColor', 'w', 'LineWidth', 1.5);
    title('Day 1', 'FontWeight', 'bold'); 
    ylabel('Values', 'FontWeight', 'bold'); 
    xlabel('Variation', 'FontWeight', 'bold'); 
    
    legend(h1(1:3), 'CO', 'ST', 'RO');
    xticks(1:3);
    xticklabels({'NW', 'ZT', 'GA'});
    grid on;
    
    % Day 2
    subplot(1, 2, 2);
    h2 = errorbar(1:4, [CO_day2; ST_day2; RO_day2], [CO_std_day2; ST_std_day2; RO_std_day2], 'o-', ...
        'MarkerSize', 8, 'MarkerFaceColor', 'w', 'LineWidth', 1.5);
    title('Day 2', 'FontWeight', 'bold'); 
    ylabel('Values', 'FontWeight', 'bold'); 
    xlabel('Variation', 'FontWeight', 'bold'); 
    
    legend(h2(1:3), 'CO', 'ST', 'RO'); 
    xticks(1:4);
    xticklabels({'NW', 'ZT', 'GA', 'OP'});
    grid on;

    %
    % Create arrays/lists for the raw data
    
    % Day 1 
    CO_NW_Day1_data = [distance.CO3.Day1.NW1;distance.CO3.Day1.NW2;
                       distance.CO4.Day1.NW1;distance.CO4.Day1.NW2;  % Raw data for CO group, NW condition, Day 1
                       distance.CO5.Day1.NW1;distance.CO5.Day1.NW2];
    CO_ZT_Day1_data = [distance.CO3.Day1.ZT1;distance.CO3.Day1.ZT2;
                       distance.CO4.Day1.ZT1;distance.CO4.Day1.ZT2;  % Raw data for CO group, ZT condition, Day 1
                       distance.CO5.Day1.ZT1;distance.CO5.Day1.ZT2];
    CO_GA_Day1_data = [distance.CO3.Day1.GA1;distance.CO3.Day1.GA2;
                       distance.CO4.Day1.GA1;distance.CO4.Day1.GA2;  % Raw data for CO group, GA condition, Day 1
                       distance.CO5.Day1.GA1;distance.CO5.Day1.GA2];
    
    ST_NW_Day1_data = [distance.ST3.Day1.NW1;distance.ST3.Day1.NW2;
                       distance.ST4.Day1.NW1;distance.ST4.Day1.NW2;  % Raw data for ST group, NW condition, Day 1
                       distance.ST5.Day1.NW1;distance.ST5.Day1.NW2];
    ST_ZT_Day1_data = [distance.ST3.Day1.ZT1;distance.ST3.Day1.ZT2;
                       distance.ST4.Day1.ZT1;distance.ST4.Day1.ZT2;  % Raw data for ST group, ZT condition, Day 1
                       distance.ST5.Day1.ZT1;distance.ST5.Day1.ZT2];
    ST_GA_Day1_data = [distance.ST3.Day1.GA1;distance.ST3.Day1.GA2;
                       distance.ST4.Day1.GA1;distance.ST4.Day1.GA2;  % Raw data for ST group, GA condition, Day 1
                       distance.ST5.Day1.GA1;distance.ST5.Day1.GA2];
    
    RO_NW_Day1_data = [distance.RO1.Day1.NW1;distance.RO1.Day1.NW2;
                       distance.RO2.Day1.NW1;distance.RO2.Day1.NW2;  % Raw data for RO group, NW condition, Day 1
                       distance.RO5.Day1.NW1;distance.RO5.Day1.NW2];
    RO_ZT_Day1_data = [distance.RO1.Day1.ZT1;distance.RO1.Day1.ZT2;
                       distance.RO2.Day1.ZT1;distance.RO2.Day1.ZT2;  % Raw data for RO group, ZT condition, Day 1
                       distance.RO5.Day1.ZT1;distance.RO5.Day1.ZT2];
    RO_GA_Day1_data = [distance.RO1.Day1.GA1;distance.RO1.Day1.GA2;
                       distance.RO2.Day1.GA1;distance.RO2.Day1.GA2;  % Raw data for RO group, GA condition, Day 1
                       distance.RO5.Day1.GA1;distance.RO5.Day1.GA2];
    
    % Day 2
    CO_NW_Day2_data = [distance.CO3.Day2.NW1;distance.CO3.Day2.NW2;
                       distance.CO4.Day2.NW1;distance.CO4.Day2.NW2;  % Raw data for CO group, NW condition, Day 2
                       distance.CO5.Day2.NW1;distance.CO5.Day2.NW2];
    CO_ZT_Day2_data = [distance.CO3.Day2.ZT1;distance.CO3.Day2.ZT2;
                       distance.CO4.Day2.ZT1;distance.CO4.Day2.ZT2;  % Raw data for CO group, ZT condition, Day 2
                       distance.CO5.Day2.ZT1;distance.CO5.Day2.ZT2];
    CO_GA_Day2_data = [distance.CO3.Day2.GA1;distance.CO3.Day2.GA2;
                       distance.CO4.Day2.GA1;distance.CO4.Day2.GA2;  % Raw data for CO group, GA condition, Day 2
                       distance.CO5.Day2.GA1;distance.CO5.Day2.GA2];
    CO_OP_Day2_data = [distance.CO3.Day2.OP1;distance.CO3.Day2.OP2;
                       distance.CO4.Day2.OP1;distance.CO4.Day2.OP2;  % Raw data for CO group, OP condition, Day 2
                       distance.CO5.Day2.OP1;distance.CO5.Day2.OP2];
    
    ST_NW_Day2_data = [distance.ST3.Day2.NW1;distance.ST3.Day2.NW2;
                       distance.ST4.Day2.NW1;distance.ST4.Day2.NW2;  % Raw data for ST group, NW condition, Day 2
                       distance.ST5.Day2.NW1;distance.ST5.Day2.NW2];
    ST_ZT_Day2_data = [distance.ST3.Day2.ZT1;distance.ST3.Day2.ZT2;
                       distance.ST4.Day2.ZT1;distance.ST4.Day2.ZT2;  % Raw data for ST group, ZT condition, Day 2
                       distance.ST5.Day2.ZT1;distance.ST5.Day2.ZT2];
    ST_GA_Day2_data = [distance.ST3.Day2.GA1;distance.ST3.Day2.GA2;
                       distance.ST4.Day2.GA1;distance.ST4.Day2.GA2;  % Raw data for ST group, GA condition, Day 2
                       distance.ST5.Day2.GA1;distance.ST5.Day2.GA2];
    
    RO_NW_Day2_data = [distance.RO1.Day2.NW1;distance.RO1.Day2.NW2;
                       distance.RO2.Day2.NW1;distance.RO2.Day2.NW2;  % Raw data for RO group, NW condition, Day 2
                       distance.RO5.Day2.NW1;distance.RO5.Day2.NW2];
    RO_ZT_Day2_data = [distance.RO1.Day2.ZT1;distance.RO1.Day2.ZT2;
                       distance.RO2.Day2.ZT1;distance.RO2.Day2.ZT2;  % Raw data for RO group, ZT condition, Day 2
                       distance.RO5.Day2.ZT1;distance.RO5.Day2.ZT2];
    RO_GA_Day2_data = [distance.RO1.Day2.GA1;distance.RO1.Day2.GA2;
                       distance.RO2.Day2.GA1;distance.RO2.Day2.GA2;  % Raw data for RO group, GA condition, Day 2
                       distance.RO5.Day2.GA1;distance.RO5.Day2.GA2];
    RO_OP_Day2_data = [distance.RO1.Day2.OP1;distance.RO1.Day2.OP2;
                       distance.RO2.Day2.OP1;distance.RO2.Day2.OP2;  % Raw data for RO group, OP condition, Day 2
                       distance.RO5.Day2.OP1;distance.RO5.Day2.OP2];

    % Plots
    boxColors = [
        0, 0.4470, 0.7410; % Blue
        0.8500, 0.3250, 0.0980; % Orange
        0.9290, 0.6940, 0.1250; % Yellow
        0.4940, 0.1840, 0.5560; % Purple
    ];
    
    % Day 1 plot
    Normal_walking = [CO_NW_Day1_data; ST_NW_Day1_data; RO_NW_Day1_data];
    Zero_torque = [CO_ZT_Day1_data; ST_ZT_Day1_data; RO_ZT_Day1_data];
    Generic_Assistance = [CO_GA_Day1_data; ST_GA_Day1_data; RO_GA_Day1_data];
    group = [ones(size(Normal_walking));
             2 * ones(size(Zero_torque));
             3 * ones(size(Generic_Assistance))];
    
    figure;
    h = boxplot([Normal_walking; Zero_torque; Generic_Assistance], group, ...
        'Colors', 'k', 'OutlierSize', 1, 'Symbol', '');
    
    % Customize the plot
    xticks(1:3);
    xticklabels({'Normal Walking', 'Zero Torque', 'Generic Assistance'});
    ylabel('Mean variability in distance between CoP and CoM', 'FontWeight', 'bold');
    title('Day 1');
    
    for i = 1:length(unique(group))
        patch(get(h(5, i), 'XData'), get(h(5, i), 'YData'), boxColors(i,:), 'FaceAlpha', 0.5);
    end

    figure;
    
    % Day 2 plot
    Normal_walkingD2 = [CO_NW_Day2_data; ST_NW_Day2_data; RO_NW_Day2_data];
    Zero_torqueD2 = [CO_ZT_Day2_data; ST_ZT_Day2_data; RO_ZT_Day2_data];
    Generic_AssistanceD2 = [CO_GA_Day2_data; ST_GA_Day2_data; RO_GA_Day2_data];
    Optimal_AssistanceD2 = [CO_OP_Day2_data; RO_OP_Day2_data];
    
    group = [ones(size(Normal_walkingD2));
             2 * ones(size(Zero_torqueD2));
             3 * ones(size(Generic_AssistanceD2));
             4 * ones(size(Optimal_AssistanceD2))];
    
    % Create box plot
    h = boxplot([Normal_walkingD2; Zero_torqueD2; Generic_AssistanceD2; Optimal_AssistanceD2], group, ...
        'Colors', 'k', 'OutlierSize', 1, 'Symbol', '');
    
    % Customize the plot
    xticks(1:4);
    xticklabels({'Normal Walking', 'Zero Torque', 'Generic Assistance','Optimal Assistance'});
    ylabel('Mean variability in distance between CoP and CoM', 'FontWeight', 'bold');
    title('Day 2');
    
    colors = repmat(boxColors, ceil(size(h, 2) / size(boxColors, 1)), 1);
    for i = 1:size(h, 2)
        patch(get(h(5, i), 'XData'), get(h(5, i), 'YData'), colors(i, :), 'FaceAlpha', 0.5);
    end

end



% Data Analyze function
function [mean_struct, std_struct] = analyze_data(distance, participants, day, activities, sample_sizes,mean_struct,std_struct)
    % Initialize arrays
    num_combinations = length(participants) * length(activities);
    means = zeros(1, num_combinations);
    std_devs = zeros(1, num_combinations);

    % Loop through each participant and activity
    i = 1;
    for p = 1:length(participants)
        participant = participants(p);
        for a = 1:length(activities)
            activity = activities(a);
            % Check if the file exists for the current participant, day, and activity
            file_path = fullfile(pwd, participant, day, activity + ".mat");
            if isfile(file_path)
                % Access the data from the distance structure
                cur_mean = mean(distance.(participant).(day).(activity));
                cur_std = std(distance.(participant).(day).(activity));
                means(i) = cur_mean;
                std_devs(i) = cur_std;
            end
            i = i + 1;
        end
    end

    % Calculate Σx and Σx^2 for each group
    sum_x = means .* sample_sizes;
    sum_x2 = std_devs.^2 .* (sample_sizes - 1) + (sum_x.^2 ./ sample_sizes);

    % Calculate combined tn, tx, and txx
    combined_n = sum(sample_sizes);
    combined_sum_x = sum(sum_x);
    combined_sum_x2 = sum(sum_x2);

    % Calculate combined mean
    combined_mean = combined_sum_x / combined_n;

    % Calculate combined standard deviation
    combined_std_dev = sqrt((combined_sum_x2 - (combined_sum_x^2 / combined_n)) / (combined_n - 1));

    % Display results based on participants
    if isequal(participants, ["CO3", "CO4", "CO5"])
        disp([day, '-Activities:', strjoin(activities, ', ')]);
        disp(['Mean for Continued Optimization: ', num2str(combined_mean)]);
        disp(['Std for Continued Optimization: ', num2str(combined_std_dev)]);
        mean_struct.(day).(activity{1}).CO = combined_mean;
        std_struct.(day).(activity{1}).CO = combined_std_dev;
        disp(" ");
    elseif isequal(participants, ["ST3", "ST4", "ST5"])
        disp([day, '-Activities:', strjoin(activities, ', ')]);
        disp(['Mean for Static Training: ', num2str(combined_mean)]);
        disp(['Std for Static Training: ', num2str(combined_std_dev)]);
        mean_struct.(day).(activity{1}).ST = combined_mean;
        std_struct.(day).(activity{1}).ST = combined_std_dev;
        disp(" ");
    elseif isequal(participants, ["RO1", "RO2", "RO5"])
        disp([day, '-Activities:', strjoin(activities, ', ')]);
        disp(['Mean for Reoptimization: ', num2str(combined_mean)]);
        disp(['Std for Reoptimization: ', num2str(combined_std_dev)]);
        mean_struct.(day).(activity{1}).RO = combined_mean;
        std_struct.(day).(activity{1}).RO = combined_std_dev;
        disp(" ");
    end
end
