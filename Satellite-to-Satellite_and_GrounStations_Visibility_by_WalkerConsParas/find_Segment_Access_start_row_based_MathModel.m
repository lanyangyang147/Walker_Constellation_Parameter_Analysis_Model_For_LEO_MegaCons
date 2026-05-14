function [output_Segment_start_row] = find_Segment_Access_start_row_based_MathModel(init_start_row,Mathematics_distance)
%FIND_SEGMENT_ACCESS_START_ROW_BASED_MATHMODEL 此处显示有关此函数的摘要
%   此处显示详细说明
for k = init_start_row:size(Mathematics_distance,1)
    if Mathematics_distance(k,2) ~= 0
        Segment_start_row = k;
        break;
    elseif k == size(Mathematics_distance,1)
        Segment_start_row = k;
        break;
    end
end
%output
output_Segment_start_row = Segment_start_row;
end

