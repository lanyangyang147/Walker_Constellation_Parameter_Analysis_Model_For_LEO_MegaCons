function [output_Matching_distance] = filling_back_data_based_MinValue_for_intermittentLink(STK_extremeValue_row,Mathematics_extremeValue_row,STK_distance,Mathematics_distance,STK_extreme_min_end_row,Math_extreme_min_end_row,Matching_distance)
%FILLING_THE_BACK_DATA_BASED_EXTREMEVALUE 此处显示有关此函数的摘要
%   此处显示详细说明
%-----Backward-----
source_STK_backward_row = STK_extremeValue_row;
des_Math_backward_row = Mathematics_extremeValue_row;
while source_STK_backward_row <= size(STK_distance,1)
    Matching_distance(des_Math_backward_row,3) = STK_distance(source_STK_backward_row,1);
    Matching_distance(des_Math_backward_row,4) = STK_distance(source_STK_backward_row,2);
    %------break--------
    %STK_extreme_min_end_row,Math_extreme_min_end_row
    if source_STK_backward_row == STK_extreme_min_end_row || des_Math_backward_row == Math_extreme_min_end_row
        break;
    end
    %------update variable--------
    source_STK_backward_row = source_STK_backward_row + 1;
    des_Math_backward_row = des_Math_backward_row + 1;    
end
%output
output_Matching_distance = Matching_distance;
end

