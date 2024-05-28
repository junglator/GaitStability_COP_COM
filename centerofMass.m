function [CoMx, CoMy] = centerofMass(file_path, weight)
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
    % Calculate the center of mass (CoM) coordinates given the ground reaction force (GRF) data
    %
    % Inputs:
    %   subject_folder: Folder containing subject data
    %   day: Specific day data
    %   controller: Type of controller used
    %   weight: Subject weight (kg)
    %
    % Outputs:
    %   CoMx: Center of mass position in the x direction (m)
    %   CoMy: Center of mass position in the y direction (m)
    %
    % Author:
    %   Aditya Srivastava
    %   Email: srivastavaadi177@gmail.com
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
    % Load GRF data 
    data = load(file_path);

    % Sampling time
    dt = 1; % Seconds (s)

    % Set the threshold for vertical force (in Newtons)
    thres = 100;

    % Filtering the data: set data.LFz and data.RFz values below threshold to NaN
    data.LFz(data.LFz < thres) = 0;
    data.RFz(data.RFz < thres) = 0;

    % Find indices for which value of verticle force is zero
    getLFzzeroindices = find(data.LFz == 0);
    getRFzzeroindices = find(data.RFz == 0);

    % Setting values of force component in other direction to zero if the
    % respective foot is in the air
    data.LFx(getLFzzeroindices) = 0;
    data.RFx(getRFzzeroindices) = 0;

    data.LFy(getLFzzeroindices) = 0;
    data.RFy(getRFzzeroindices) = 0;

    % Ground reaction forces
    grfx = data.LFx + data.RFx;
    grfy = data.LFy + data.RFy;

    % Calculate mean values for interval of 500 for ground reaction forces
    grfx = mean_values(grfx);
    grfy = mean_values(grfy);

    % Initialize arrays for CoM coordinates
    CoMx = zeros(length(grfx), 1);
    CoMy = zeros(length(grfy), 1);

    % Get the initial coordinates of the CoM
    [CoMx(1), CoMy(1)] = initCoM(data);

    % Calculate accelerations (m/s^2)
    accx = grfx / weight; 
    accy = grfy / weight; 

    % Initialize velocity arrays
    velx = zeros(length(accx), 1);
    vely = zeros(length(accy), 1);

    % Velocity calculation (m/s)
    for i = 2:length(accx)
        velx(i) = 0.5 * dt * (accx(i-1) + accx(i));
        vely(i) = 0.5 * dt * (accy(i-1) + accy(i));
    end

    % Position calculation (m)
    for j = 2:length(accx)
        CoMx(j) = 0.5 * dt * (velx(j-1) + velx(j)) + CoMx(1);
        CoMy(j) = 0.5 * dt * (vely(j-1) + vely(j)) + CoMy(1);
    end
end
