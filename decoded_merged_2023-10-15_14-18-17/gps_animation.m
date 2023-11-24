gps_data = readtable('gps.csv');
coordinate = gps_data{7:end, [4,5]};
coordinate(:, 1) = coordinate(:, 1)-coordinate(1, 1);
coordinate(:, 2) = coordinate(:, 2)-coordinate(1, 2);

x = coordinate(:, 1);
y = coordinate(:, 2);

% Create a figure for the animation
figure
hold on;

% Initialize the plot with empty data
plotHandle = plot(NaN, NaN, 'x');
xlabel('Lontitude');
ylabel('Latitude');
title('Animated Track Plot');
grid on; grid minor;

% Set the axis limits as per your data
axis([min(x), max(x), min(y), max(y)]);

% Loop to gradually reveal the points over time
for i = 1:length(x)
    xdata = x(1:i);
    ydata = y(1:i);
    
    set(plotHandle, 'XData', xdata, 'YData', ydata);
    drawnow;
    
    % Add a pause to control the animation speed (adjust as needed)
    pause(0.01);  % 1 second pause between points
end