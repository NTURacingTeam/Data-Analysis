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
    