function [CoMx, CoMy] = initCoM(var)
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
    % This function calculates the initial coordinates for the Center of
    % Mass (CoM) for the centerofMass.m function using the subject's quiet standing (QS)
    % ground reaction force var.
    %
    % Inputs:
    %   var - a structure containing the variables:
    %         LFx (N) - Left foot force in the x-direction
    %         LFy (N) - Left foot force in the y-direction
    %         LFz (N) - Left foot force in the z-direction
    %         RFx (N) - Right foot force in the x-direction
    %         RFy (N) - Right foot force in the y-direction
    %         RFz (N) - Right foot force in the z-direction
    %         LMy (Nm) - Left foot moment about the y-axis
    %         LMx (Nm) - Left foot moment about the x-axis
    %         RMy (Nm) - Right foot moment about the y-axis
    %         RMx (Nm) - Right foot moment about the x-axis
    %
    % Outputs:
    %   CoMx - the initial x-coordinate of the Center of Mass (meters)
    %   CoMy - the initial y-coordinate of the Center of Mass (meters)
    %
    % Author:
    %   Aditya Srivastava
    %   srivastavaadi177@gmail.com
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

    % Initialize CoMx and CoMy arrays with zeros to store Center of Pressure (CoP) coordinates
    CoMx = zeros(length(var.LFx), 1);
    CoMy = zeros(length(var.LFy), 1);

    % Define the coordinates of the left and right corners of the force plate (in meters)
    Xl = 0.25;  % X coordinate of the left corner
    Yl = 0;     % Y coordinate of the left corner
    Xr = -0.25; % X coordinate of the right corner
    Yr = 0;     % Y coordinate of the right corner

    % Set the threshold for vertical force (in Newtons)
    thres = 100;

    % Filtering the var: set var.LFz and var.RFz values below threshold to NaN
    var.LFz(var.LFz < thres) = NaN;
    var.RFz(var.RFz < thres) = NaN;


    % Calculating CoP if both feet are in contact with the ground
    zero_indicesX = find(CoMx == 0);
    zero_indicesY = find(CoMy == 0);

    CoMx(zero_indicesX) = ((-var.RMy(zero_indicesX) ./ (var.RFz(zero_indicesX)) + Xr) .* ((var.LFz(zero_indicesX) ./ (var.LFz(zero_indicesX) + var.RFz(zero_indicesX))))) ...
                          +((-var.LMy(zero_indicesX) ./ (var.LFz(zero_indicesX)) + Xl) .* ((var.RFz(zero_indicesX) ./ (var.RFz(zero_indicesX) + var.LFz(zero_indicesX)))));

    CoMy(zero_indicesY) = ((var.LMx(zero_indicesY) ./ (var.LFz(zero_indicesY)) + Yl) .* ((var.RFz(zero_indicesY) ./ (var.RFz(zero_indicesY) + var.LFz(zero_indicesY))))) ...
                          +((var.RMx(zero_indicesY) ./ (var.RFz(zero_indicesY)) + Yr) .* ((var.LFz(zero_indicesY) ./ (var.RFz(zero_indicesY) + var.LFz(zero_indicesY)))));

    % Find indices for NaN values in data.LFz and data.RFz data
    CoMx_nan_indices = (isnan(CoMx));
    CoMy_nan_indices = (isnan(CoMy));

    CoMx = CoMx(~CoMx_nan_indices);
    CoMy = CoMy(~CoMy_nan_indices);

    % % Calculate CoP (Center of Pressure) when both feet are in contact with the ground
    % CoMx = ((-var.RMy ./ var.RFz + Xr) .* (var.LFz ./ (var.LFz + var.RFz))) ...
    %        + ((-var.LMy ./ var.LFz + Xl) .* (var.RFz ./ (var.RFz + var.LFz)));
    % 
    % CoMy = ((var.LMx ./ var.LFz + Yl) .* (var.RFz ./ (var.RFz + var.LFz))) ...
    %        + ((var.RMx ./ var.RFz + Yr) .* (var.LFz ./ (var.RFz + var.LFz)));

    % Calculate the mean of the coordinates to obtain the initial position of CoM
    CoMx = median(CoMx);
    CoMy = median(CoMy);
end
