function [output_Seperated_STK_distance] = find_Segement_Accessed_distance(Segment_end_row,Segment_start_row,column,Seperated_STK_distance,STK_distance)
%FIND_SEGEMENT_ACCESSED_DISTANCE 此处显示有关此函数的摘要
%   此处显示详细说明
%---------Break-------
count = 0;
for k = Segment_start_row:Segment_end_row
    count = count + 1;
    Seperated_STK_distance(count,column) = STK_distance(k,1);
    Seperated_STK_distance(count,column + 1) = STK_distance(k,2);
end
%output
output_Seperated_STK_distance = Seperated_STK_distance;
end

