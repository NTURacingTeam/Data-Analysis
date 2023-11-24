% Load marked points
lapMark1_m = [lapMark1.DataIndex];
lapMark1_m = sort(lapMark1_m); 
for i = 1:+2:size(lapMark1_m, 2)-1
    lapMark1_m(2, i) = (lapMark1_m(1, i+2) - lapMark1_m(1, i))/100;
end


% Calculate laptime by subtracting values