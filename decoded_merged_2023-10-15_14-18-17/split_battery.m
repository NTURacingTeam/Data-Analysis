battery_data = readtable('battery.csv');
% lapMark1_m = [1697352168, 1697352244, 1697352318, 1697352400, 1697352470, 1697352541, 1697352618, 1697352692, 1697352764, 1697352835];
lapMark1_m = sort([cursor_info_1.DataIndex]);
battery_time = battery_data(:, 1);
j = 1;
k = length(lapMark1_m);
battery_index = zeros(1, k);
for i = 1:+1:height(battery_time)-1
    if (battery_time{i, 1} >= lapMark1_m(j)) && (battery_time{i ,1} < lapMark1_m(j+1))
        battery_index(1, j) = i;
        j = j + 1;
    end
end

base_folder = 'battery_data_analysis';
for i = 1:height(battery_index)-1
    battery_sub_data = battery_data(battery_index(i):battery_index(i+1), :);
    subfolder_name = fullfile(base_folder, sprintf('test_battery_%d', i));
    mkdir(subfolder_name);
    output_battery_filename = fullfile(subfolder_name, sprintf('battery_%d.csv', i));
    writetable(battery_sub_data, output_battery_filename);
end