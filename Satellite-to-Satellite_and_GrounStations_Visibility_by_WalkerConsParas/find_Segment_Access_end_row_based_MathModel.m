function [output_Segment_end_row] = find_Segment_Access_end_row_based_MathModel(Segment_start_row,Mathematics_distance)
%FIND_SEGMENT_ACCESS_END_ROW_BASED_MATHMODEL 此处显示有关此函数的摘要
%   此处显示详细说明

for k = Segment_start_row:size(Mathematics_distance,1)
    if Mathematics_distance(k,2) == 0
        Segment_end_row = k - 1;
        break;
    elseif k == size(Mathematics_distance,1)
        Segment_end_row = k;    
    end
end

%output
output_Segment_end_row = Segment_end_row;
end

