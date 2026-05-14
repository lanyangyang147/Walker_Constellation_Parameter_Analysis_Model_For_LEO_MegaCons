function [output_STK_min_value_start_row,output_STK_min_value_end_row] = find_min_value_corresponding_row(STK_min_value,Segment_STK_distance,STK_distance_interval,STK_distance)
%FIND_MIN_VALUE_CORRESPONDING_ROW 此处显示有关此函数的摘要
%   此处显示详细说明

for k = 1:size(Segment_STK_distance,1)
    if Segment_STK_distance(k,2) == STK_min_value
        STK_min_value_Time = Segment_STK_distance(k,1);
        break;
    end
end

for k = 1:size(STK_distance,1)
    if STK_distance(k,1) == STK_min_value_Time
        STK_min_row = k;
        break;
    end
end

if STK_min_row == 1
    STK_min_value_start_row = 1;
    %-----find the end row-----
    STK_min_value_end_row = find_Segment_Access_end_row(STK_min_value_start_row,STK_distance_interval,STK_distance);
else
    STK_min_value_end_row = STK_min_row;
    %-----find the start row-----
    STK_min_value_start_row = find_Segment_Access_start_row_based_STK(STK_min_value_end_row,STK_distance_interval,STK_distance);
end

%output
output_STK_min_value_start_row = STK_min_value_start_row;
output_STK_min_value_end_row = STK_min_value_end_row;
end

