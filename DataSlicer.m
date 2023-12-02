% Slice the original data
%{
    The original data will be sliced in to parts according to lap counts
    The sliced data of lap 'x' will be put into the 'lap_x' folder under
    'data'sliced' folder
%}

clc; clear;

%% Impot data and show the steering angle figure
% Load the steeing angle data for lap count evaluation
sensorData = readtable('./data_original/sensor.csv');
steeringAngle = sensorData{2:end, [1, 7]};
% Plot the steering Angle
plot(steeringAngle(:, 1), steeringAngle(:, 2)); %(time, steering angle)
xlabel('Time [s]', 'Interpreter','latex','FontSize',12);
ylabel('Steering Angle [deg]', 'Interpreter','latex','FontSize',12);
title('Steering Angle', 'Interpreter','latex','FontSize',14);
grid on; grid minor;

% Next we need to pin the lap counting time by hand in the figure window
disp('Pin the points for lap distinguishing in the figure and export them as "lapmark"');

% Load other datas
imuData = readtable('./data_original/imu.csv');
batteryData = readtable('./data_original/battery.csv');
inverterData = readtable('./data_original/inverter_data.csv');
systemStatsData = readtable('./data_original/system_stats.csv');

%% Create sub-folders in 'data_sliced' folder for each lap
% First load the time pins from the previous step and then list the data index for later evaluation
lapmark_dataIndex = sort([lapmark.DataIndex]); 
% get the detailed data from lapmark
lapmark_timePinValue_temp = [lapmark.Position];
% Extract only the time value out
lapmark_timePinValue = [];
for i=1:+1:length(lapmark_timePinValue_temp)/2
    lapmark_timePinValue(i) = lapmark_timePinValue_temp(2*i-1);
end
lapmark_timePinValue = sort(lapmark_timePinValue);
% The sliced folder path
slicedFolder_path = './data_sliced/';


% Create sub folders and slice data
%%% variable for file data iteration
imu_iterate = 1;
battery_iterate = 1;
inverter_iterate = 1;
systemStats_iterate = 1;
%%%
lapCount = 0;
for i=1:+1:length(lapmark_dataIndex)-1
    % if the time gap is too large, don't treat it as one lap
    if steeringAngle(lapmark_dataIndex(i+1)) - steeringAngle(lapmark_dataIndex(i)) < 120
        lapCount = lapCount + 1;
        
        % Create sub-folders named by lap count
        currentLapFolder = fullfile(slicedFolder_path, sprintf('lap_%d', lapCount));
        mkdir(currentLapFolder);
        
        %%% Sensor data ---------------------------------------------------
        % Slice data
        % 1. Get boundary of sensor data, directly use the data index of lapmark
        lowerBound_index = lapmark_dataIndex(i);      % The lower bound index of the copied data
        upperBound_index = lapmark_dataIndex(i+1);    % The upper bound index of the copied data
        % 2. Copy the specific part of the data
        sensorData_sliced = sensorData(lowerBound_index:upperBound_index, :);
        lowerBound_timeValue = sensorData_sliced{1,1}; % the starting time of current lap
        upperBound_timeValue = sensorData_sliced{size(sensorData_sliced, 1) ,1}; % the end time of current lap
        % 3. The output file and its path
        output_sensor_file = fullfile(currentLapFolder, 'sensor.csv');
        writetable(sensorData_sliced, output_sensor_file);
        %%% Sensor data end -----------------------------------------------
        
        %%% IMU data ------------------------------------------------------
        % 1. find the lower and upper bound by looking in the imu.csv
        lowerBound_found = false;
        upperBound_found = false;
        for j=imu_iterate:+1:size(imuData, 1)-1
            % find the lower bound by comparing the time value
            if ~lowerBound_found
                if imuData{j, 1} >= lowerBound_timeValue
                    lowerBound_index = j; 
                    lowerBound_found = true;
                end
            end        
            % break this loop if the upper bound is found           
            if ~upperBound_found
                if imuData{j, 1} >= upperBound_timeValue
                    upperBound_index = j;
                    upperBound_found = true;
                    % update the iteration variable to reduce the time complexity to N
                    imu_iterate = j; 
                    break
                end
            end         
        end
        % 2. Copy the specific part of data
        imuData_sliced = imuData(lowerBound_index:upperBound_index, :);
        % 3. The output file and its path
        output_imu_file = fullfile(currentLapFolder, 'imu.csv');
        writetable(imuData_sliced, output_imu_file);
        %%% IMU data end --------------------------------------------------
        
        %%% Battery data --------------------------------------------------
        % 1. find the lower and upper bound by looking in the battery.csv
        lowerBound_found = false;
        upperBound_found = false;
        for j=battery_iterate:+1:size(batteryData, 1)-1
            % find the lower bound by comparing the time value
            if ~lowerBound_found
                if batteryData{j, 1} >= lowerBound_timeValue
                    lowerBound_index = j;
                    lowerBound_found = true;
                end
            end
            % break this loop if the upper bound is found           
            if ~upperBound_found
                if batteryData{j, 1} >= upperBound_timeValue
                    upperBound_index = j;
                    upperBound_found = true;
                    % update the iteration variable to reduce the time complexity to N
                    battery_iterate = j; 
                    break
                end
            end
        end
        % 2. Copy the specific part of data
        batteryData_sliced = batteryData(lowerBound_index:upperBound_index, :);
        % 3. The output file and its path
        output_battery_file = fullfile(currentLapFolder, 'battery.csv');
        writetable(batteryData_sliced, output_battery_file);
        %%% Battery data end ----------------------------------------------
        
        %%% Inverter data --------------------------------------------------
        % 1. find the lower and upper bound by looking in the inverter_data.csv
        lowerBound_found = false;
        upperBound_found = false;
        for j=inverter_iterate:+1:size(inverterData, 1)-1
            % find the lower bound by comparing the time value
            if ~lowerBound_found
                if inverterData{j, 1} >= lowerBound_timeValue
                    lowerBound_index = j;
                    lowerBound_found = true;
                end
            end
            % break this loop if the upper bound is found           
            if ~upperBound_found
                if inverterData{j, 1} >= upperBound_timeValue
                    upperBound_index = j;
                    upperBound_found = true;
                    % update the iteration variable to reduce the time complexity to N
                    inverter_iterate = j; 
                    break
                end
            end
        end
        % 2. Copy the specific part of data
        inverterData_sliced = inverterData(lowerBound_index:upperBound_index, :);
        % 3. The output file and its path
        output_inverter_file = fullfile(currentLapFolder, 'inverter_data.csv');
        writetable(inverterData_sliced, output_inverter_file);
        %%% Inverter data end ----------------------------------------------
        
        %%% System Stats data --------------------------------------------------
        % 1. find the lower and upper bound by looking in the system_stats.csv
        lowerBound_found = false;
        upperBound_found = false;
        for j=systemStats_iterate:+1:size(systemStatsData, 1)-1
            % find the lower bound by comparing the time value
            if ~lowerBound_found
                if systemStatsData{j, 1} >= lowerBound_timeValue
                    lowerBound_index = j;
                    lowerBound_found = true;
                end
            end
            % break this loop if the upper bound is found           
            if ~upperBound_found
                if systemStatsData{j, 1} >= upperBound_timeValue
                    upperBound_index = j;
                    upperBound_found = true;
                    % update the iteration variable to reduce the time complexity to N
                    systemStats_iterate = j; 
                    break
                end
            end
        end
        % 2. Copy the specific part of data
        systemStatsData_sliced = systemStatsData(lowerBound_index:upperBound_index, :);
        % 3. The output file and its path
        output_systemStats_file = fullfile(currentLapFolder, 'system_stats.csv');
        writetable(systemStatsData_sliced, output_systemStats_file);
        %%% System Stats data end ----------------------------------------------
    end
end