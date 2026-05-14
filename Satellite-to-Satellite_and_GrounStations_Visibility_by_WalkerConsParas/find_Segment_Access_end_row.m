function [output_Segment_end_row] = find_Segment_Access_end_row(Segment_start_row,STK_distance_interval,STK_distance)
%FIND_SEGMENT_ACCESS_END_ROW 此处显示有关此函数的摘要
%   此处显示详细说明
for k = Segment_start_row:size(STK_distance,1)
    row_time = STK_distance(k,1);
    next_row_time = STK_distance(k + 1,1);
    diff_value = next_row_time - row_time;
    if diff_value ~= STK_distance_interval
        Segment_end_row = k;
        break;
    else
        if k == size(STK_distance,1) - 1
            Segment_end_row = size(STK_distance,1);
            break;
        end
    end
end
%output
output_Segment_end_row = Segment_end_row;
end

