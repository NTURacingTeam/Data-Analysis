sensor_data = readtable('sensor.csv');
% lapMark1_m = [1697352168, 1697352244, 1697352318, 1697352400, 1697352470, 1697352541, 1697352618, 1697352692, 1697352764, 1697352835];
lapMark1_m = sort([cursor_info_1.DataIndex]);
base_folder = 'data_analysis';
steeringAngle = sensor_data{2:end, [1, 7]};
time = steeringAngle(:, 1);
for i = 1:length(lapMark1_m)-1
    sensor_sub_data = sensor_data(lapMark1_m(i):lapMark1_m(i+1), :);
    subfolder_name = fullfile(base_folder, sprintf('test_first_driver_%d', i));
    mkdir(subfolder_name);
    output_sensor_filename = fullfile(subfolder_name, sprintf('sensor_%d.csv', i));
    writetable(sensor_sub_data, output_sensor_filename);
end
    



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

