sensor_data = readtable('sensor.csv');
imu_data = readtable('imu.csv');
gps_data = readtable('gps.csv');
battery_data = readtable('battery.csv');
inverter_data = readtable('inverter_data.csv');
% start_time_1 = [1697352168, 1697352244, 1697352318, 1697352400, 1697352470, 1697352541, 1697352618, 1697352692, 1697352764, 1697352835];
base_folder = 'data_anlysis';
steeringAngle = sensor_data{2:end, [1, 7]};
time = steeringAngle(:, 1);
k = 1;
j = 1;
for i = 1:length(start_time_1)
    sensor_sub_data = sensor_data(time >= start_time_1(i) & time < start_time_1(i+1), :);
    imu_sub_data = imu_data(time >= start_time_1(i) & time < start_time_1(i+1), :);
    gps_sub_data = gps_data(time >= start_time_1(i) & time < start_time_1(i+1), :);
    inverter_sub_data = inverter_data(time >= start_time_1(i) & time < start_time_1(i+1), :);
    battery_sub_data = battery_data(time >= start_time_1(i) & time < start_time_1(i+1), :);
    
    subfolder_name = fullfile(base_folder, spirntf('first_driver_%d', i));
    mkdir(subfolder_name);
    
    output_sensor_filename = fullfile(subfolder_name, sprintf('sensor_%d.csv', i));
    output_imu_filename = fullfile(subfolder_name, sprintf('imu_%d.csv', i));
    output_gps_filename = fullfile(subfolder_name, sprintf('gps_%d.csv', i));
    output_inverter_filename = fullfile(subfolder_name, sprintf('inverter_%d.csv', i));
    output_battery_filename = fullfile(subfolder_name, sprintf('battery_%d.csv', i));

    writetable(sensor_sub_data, output_sensor_filename);
    writetable(imu_sub_data, output_imu_filename);
    writetable(gps_sub_data, output_gps_filename);
    writetable(inverter_sub_data, output_inverter_filename);
    writetable(battery_sub_data, output_inverter_filename);
end
    