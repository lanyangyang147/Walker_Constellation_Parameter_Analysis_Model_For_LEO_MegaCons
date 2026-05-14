function [output_Math_min_value_start_row,output_Math_min_value_end_row] = find_min_value_corresponding_row_based_MathematicsModel(Math_min_value,Segment_Math_distance,Mathematics_distance)
%FIND_MIN_VALUE_CORRESPONDING_ROW_BASED_MATHEMATICSMODEL 此处显示有关此函数的摘要
%   此处显示详细说明

for k = 1:size(Segment_Math_distance,1)
    if Segment_Math_distance(k,2) == Math_min_value
        Math_min_value_Phase = Segment_Math_distance(k,1);
        break;
    end
end

for k = 1:size(Mathematics_distance,1)
    if Mathematics_distance(k,1) == Math_min_value_Phase
        Math_min_value_row = k;
        break;
    end
end

if Math_min_value_row == 1
    Math_min_value_start_row = 1;
    %-----find the end row-----
    Math_min_value_end_row = find_Segment_Access_end_row_based_MathModel(Math_min_value_row,Mathematics_distance);
else
    Math_min_value_end_row = Math_min_value_row;
    %-----find the start row-----
    Math_min_value_start_row = find_Segment_link_Access_start_row_MathModel(Math_min_value_end_row,Mathematics_distance);
end
%output
output_Math_min_value_start_row = Math_min_value_start_row;
output_Math_min_value_end_row = Math_min_value_end_row;
end

