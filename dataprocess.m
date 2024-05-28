%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% Abbreviations:
% CO: Continued Optimization
% ST: Static Training
% RO: Reoptimization
% GA: Generic Assistance
% NW: Normal Shoe Walking
% ZT: Zero Torque
% OP: Optimized
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% Author: Aditya Srivastava
% Email: srivastavaadi177@gmail.com
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% Function to calculate distance between two points
calculateDistance = @(x1, y1, x2, y2) sqrt((x1 - x2).^2 + (y1 - y2).^2);

% Initialize the struct to hold all data
data = struct();
distance = struct();

participant_weights = [75.88, 74.88, 72.88, 57.88, 64.88, 92.88, 69.88, 93.88, 72.88]; % Participant weights including the weight of exoskeleton
Participant_heights = [1.63, 1.78, 1.73, 1.65, 1.64, 1.83, 1.71, 1.85, 1.77]; % Participant heights
participants = {'CO3', 'CO4', 'CO5', 'ST3', 'ST4', 'ST5', 'RO1', 'RO2', 'RO5'}; % Participant identifiers
days = {'Day1', 'Day2'}; % Days of data collection
activities = {'GA1', 'GA2', 'NW1', 'NW2', 'ZT1', 'ZT2', 'OP1', 'OP2'}; % Different activities

% Loop through each participant, day, and activity
for p = 1:length(participants)
    participant = participants{p};
    for d = 1:length(days)
        day = days{d};
        for a = 1:length(activities)
            activity = activities{a};
                
            % In case of Normal walking substract exoskeleton weight (i.e -0.88)
            if strcmp(activity, 'NW1') || strcmp(activity, 'NW2')
                participant_weights(p) = participant_weights(p) - 0.88;
            end 
            
            % Check if the file exists for the current participant, day, and activity
            file_path = fullfile(pwd, participant, day, [activity '.mat']);
            if isfile(file_path)
                % Load data
                [com_data_X, com_data_Y] = centerofMass(file_path, participant_weights(p));
                [cop_data_X, cop_data_Y] = centerofPressure(file_path);
                
                % Normalize data
                height_factor = Participant_heights(p) * 0.530;
                
                % Store data in the struct
                data.(participant).(day).(activity).COM.X = com_data_X(1:120);
                data.(participant).(day).(activity).COM.Y = com_data_Y(1:120);
                data.(participant).(day).(activity).COP.X = cop_data_X(1:120);
                data.(participant).(day).(activity).COP.Y = cop_data_Y(1:120);
                
                % Calculate distance between CoM and CoP
                dist = calculateDistance(com_data_X(1:120), com_data_Y(1:120), cop_data_X(1:120), cop_data_Y(1:120));
                % Normalized distance 
                distance.(participant).(day).(activity) = dist / height_factor;            
            end
        end
    end
end
