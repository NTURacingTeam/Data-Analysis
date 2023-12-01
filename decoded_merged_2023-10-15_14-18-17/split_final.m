sensor_data = readtable('sensor.csv');
imu_data = readtable('imu.csv');
battery_data = readtable('battery.csv');
inverter_data = readtable('inverter_data.csv');
% lapMark1_m = [1697352168, 1697352244, 1697352318, 1697352400, 1697352470, 1697352541, 1697352618, 1697352692, 1697352764, 1697352835];
lapMark1_m = sort([cursor_info_1.DataIndex]);
base_folder = 'data_analysis_final';
steeringAngle = sensor_data{2:end, [1, 7]};
time = steeringAngle(:, 1);
for i = 1:length(lapMark1_m)
    sensor_sub_data = sensor_data(lapMark1_m(i):lapMark1_m(i+1), :);
    imu_sub_data = imu_data(lapMark1_m(i):lapMark1_m(i+1), :);
    battery_sub_data = battery_data(lapMark1_m(i):lapMark1_m(i+1), :);
    inverter_sub_data = inverter_data(lapMark1_m(i):lapMark1_m(i+1), :);
    subfolder_name = fullfile(base_folder, sprintf('first_driver_%d', i));
    mkdir(subfolder_name);
    output_sensor_filename = fullfile(subfolder_name, sprintf('sensor_%d.csv', i));
    output_imu_filename = fullfile(subfolder_name, sprintf('imu_sensor_%d.csv', i));
    output_inverter_filename = fullfile(subfolder_name, sprintf('inverter_sensor_%d.csv', i));
    output_battery_filename = fullfile(subfolder_name, sprintf('battery_sensor_%d.csv', i));
    writetable(sensor_sub_data, output_sensor_filename)
end
    