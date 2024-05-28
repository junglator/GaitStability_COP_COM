function [CoPx, CoPy] = centerofPressure(file_path) %[CoPx, CoPy] = centerofPressure(subject_folder, day, controller)
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
    % Calculate the center of pressure (CoP) coordinates
    % given the moment and force data along with the 
    % reference position.
    %
    % Usage:
    %   [CoPx, CoPy] = centerofPressure(Mx, My, Fx, Fy, Fz, X0, Y0, Z0)
    %
    % Inputs:
    %   Mx  - Moment about the x-axis (Nm)
    %   My  - Moment about the y-axis (Nm)
    %   Fx  - Force along the x-axis (N)
    %   Fy  - Force along the y-axis (N)
    %   Fz  - Force along the z-axis (N, normal force)
    %   Xi  - X-coordinate of the reference position (m)
    %   Yi  - Y-coordinate of the reference position (m)
    %   Zi  - Z-coordinate of the reference position (m)
    %
    % Outputs:
    %   CoPx - X-coordinate of the center of pressure (m)
    %   CoPy - Y-coordinate of the center of pressure (m)
    % 
    % Formula used for calculating CoP:
    % CoPx = -RMy / Fz + Xi
    % CoPy =  RMx / Fz + Yi
    %
    % Author:
    %   Aditya Srivastava
    %   srivastavaadi177@gmail.com
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

    % Load GRF data (change the argument 1 of fullfile function according to your folder's path) 
    % data = load(fullfile(pwd,'data', subject_folder, day, controller));
    data = load(fullfile(file_path));
    
    % Initialize CoPx and CoPy arrays with zeros to store CoP coordinates
    CoPx = zeros(length(data.LFx), 1);
    CoPy = zeros(length(data.LFy), 1);

    % Offset coordinates of the left and right corners of the force plate (in meters)
    Xl = 0.25;
    Yl = 0;
    Xr = -0.25;
    Yr = 0;

    % Set the threshold for vertical force (in Newtons)
    thres = 100;

    % Filtering the data: set data.LFz and data.RFz values below threshold to NaN
    data.LFz(data.LFz < thres) = NaN;
    data.RFz(data.RFz < thres) = NaN;

    % Find indices for NaN values in data.LFz and data.RFz data
    L_nan_indices = find(isnan(data.LFz));
    R_nan_indices = find(isnan(data.RFz));

    % Calculating CoP if left foot is in the air and right foot is in
    % contact with the ground
    CoPx(L_nan_indices) = -data.RMy(L_nan_indices) ./ data.RFz(L_nan_indices) + Xr;
    CoPy(L_nan_indices) =  data.RMx(L_nan_indices) ./ data.RFz(L_nan_indices) + Yr;

    % Calculating CoP if right foot is in the air and left foot is in
    % contact with the ground
    CoPx(R_nan_indices) = -data.LMy(R_nan_indices) ./ data.LFz(R_nan_indices) + Xl;
    CoPy(R_nan_indices) =  data.LMx(R_nan_indices) ./ data.LFz(R_nan_indices) + Yl;

    % Calculating CoP if both feet are in contact with the ground
    zero_indicesX = find(CoPx == 0);
    zero_indicesY = find(CoPy == 0);

    CoPx(zero_indicesX) = ((-data.RMy(zero_indicesX) ./ (data.RFz(zero_indicesX)) + Xr) .* ((data.LFz(zero_indicesX) ./ (data.LFz(zero_indicesX) + data.RFz(zero_indicesX))))) ...
                          +((-data.LMy(zero_indicesX) ./ (data.LFz(zero_indicesX)) + Xl) .* ((data.RFz(zero_indicesX) ./ (data.RFz(zero_indicesX) + data.LFz(zero_indicesX)))));

    CoPy(zero_indicesY) = ((data.LMx(zero_indicesY) ./ (data.LFz(zero_indicesY)) + Yl) .* ((data.RFz(zero_indicesY) ./ (data.RFz(zero_indicesY) + data.LFz(zero_indicesY))))) ...
                          +((data.RMx(zero_indicesY) ./ (data.RFz(zero_indicesY)) + Yr) .* ((data.LFz(zero_indicesY) ./ (data.RFz(zero_indicesY) + data.LFz(zero_indicesY)))));

    % % Median values for ground reaction forces
    CoPx = median_values(CoPx)';
    CoPy = median_values(CoPy)';
end
