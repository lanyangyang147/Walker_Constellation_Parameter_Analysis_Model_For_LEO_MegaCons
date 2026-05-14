function [output_Segment_start_row] = find_Segment_link_Access_start_row_MathModel(Math_extreme_min_row,Mathematics_distance)
%FIND_SEGMENT_LINK_ACCESS_START_ROW_MATHMODEL 此处显示有关此函数的摘要
%   此处显示详细说明

for k = Math_extreme_min_row:-1:1
    if Mathematics_distance(k,2) == 0
        Segment_start_row = k + 1;
        break;
    elseif k == 1
        Segment_start_row = k;
        break;
    end
end

%output
output_Segment_start_row = Segment_start_row;
end

