clear; clc; close all;

%% IMU plot

%%% Load data
imu_data = csvread('imu.csv', 1, 0);
imu_data(:, 1) = imu_data(:, 1)-imu_data(1, 1);

%%% Z-gyro
figure
% 1->time; 2~4->acc_x~z; 5~7->gyro_x~z; 8~11->quat_w~z
col_num = 7; % wanted data
plot(imu_data(:,1), imu_data(:, col_num));
xlabel('Time [s]'); % Set the label for the X-axis
ylabel('gyro Z [rad/s^2]'); % Set the label for the Y-axis
title('Z axis gyro');   % Set the title for the plot
grid on;                 % Turn the grid on (optional)
                                                                                                                                                                                                                                                                                                                                                                          

%%% Three axis acceleration
figure;
for colnum=2:4
   plot(imu_data(:,1)-imu_data(1,1), imu_data(:, colnum));
   hold on;
end
xlabel('Time [s]');
ylabel('Acceleration [g]');
legend('x', 'y', 'z');
title('Acceleration of Three axes');
grid on; grid minor;

%% GPS plot
% Load data gps data
gps_data = readtable('gps.csv');
coordinate = gps_data{7:end, [4,5]};
coordinate(:, 1) = coordinate(:, 1)-coordinate(1, 1);
coordinate(:, 2) = coordinate(:, 2)-coordinate(1, 2);

x = coordinate(:, 1);
y = coordinate(:, 2);
dx = diff(x);
dy = diff(y);

figure 
% plot(coordinate(:, 1), coordinate(:,2), 'x');
quiver(x(1:end-1), y(1:end-1), dx, dy, 0, 'LineWidth', 1.5);
xlabel('x');
ylabel('y');
title('Track graph');
grid on; grid minor;

%% Motor speed
% Load data
inerter_data = readtable('inverter_data.csv');
motorSpeed = inerter_data{2:end, [1,4]};
motorSpeed(:, 1) = motorSpeed(:, 1) - motorSpeed(1, 1); % time offset

% plot
plot(motorSpeed(:, 1), motorSpeed(:, 2));
xlabel('Time [s]');
ylabel('Motor Speed [rpm]');
title('Motor Speed');
grid on; grid minor;

%% Steering angle
% Load data
sensorData = readtable('sensor.csv');
steeringAngle = sensorData{2:end, [1, 7]};
% steeringAngle(:, 1) = steeringAngle(:, 1) - steeringAngle(1, 1); % time offset

% plot
plot(steeringAngle(:, 1), steeringAngle(:, 2));
xlim([steeringAngle(1, 1), steeringAngle(size, 1)])
xlabel('Time [s]');
ylabel('Steering Angle [deg]');
title('Steering Angle');
grid on; grid minor;

%% Show lap time
% load('lapMark1_m.mat');
% disp('LapTime: '); disp(lapMark1_m(2, :));
