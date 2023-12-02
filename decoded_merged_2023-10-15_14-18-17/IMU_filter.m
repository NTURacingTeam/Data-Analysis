% Load IMU data
imu_data = csvread('imu.csv', 1, 0);

%% Moving Average Filter
% First test the Z gyro
