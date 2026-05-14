function [output_Segment_start_row] = find_Segment_Access_start_row_based_STK(STK_extreme_min_row,STK_distance_interval,STK_distance)
%FIND_SEGMENT_ACCESS_START_ROW_BASED_STK 此处显示有关此函数的摘要
%   此处显示详细说明

%STK_extreme_min_row,STK_distance_interval,STK_distance

for k = STK_extreme_min_row:-1:1
    row_time = STK_distance(k,1);
    last_row_time = STK_distance(k - 1,1);
    diff_value = row_time - last_row_time;
    if diff_value ~= STK_distance_interval
        Segment_start_row = k;
        break;
    else
        if k == 2% the second row
            Segment_start_row = 1;
            break;
        end
    end
end


%output
output_Segment_start_row = Segment_start_row;
end

