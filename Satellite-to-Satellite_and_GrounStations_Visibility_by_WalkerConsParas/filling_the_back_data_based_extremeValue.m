function [output_Matching_distance] = filling_the_back_data_based_extremeValue(STK_extremeValue_row,Mathematics_extremeValue_row,STK_distance,Mathematics_distance,Matching_distance)
%FILLING_THE_BACK_DATA_BASED_EXTREMEVALUE 此处显示有关此函数的摘要
%   此处显示详细说明
%-----Backward-----
source_STK_backward_row = STK_extremeValue_row + 1;
des_Math_backward_row = Mathematics_extremeValue_row + 1;
while source_STK_backward_row <= size(STK_distance,1)
    Matching_distance(des_Math_backward_row,3) = STK_distance(source_STK_backward_row,1);
    Matching_distance(des_Math_backward_row,4) = STK_distance(source_STK_backward_row,2);
    %------break--------
    if source_STK_backward_row == size(STK_distance,1) || des_Math_backward_row == size(Mathematics_distance,1)
        break;
    end
    %------update variable--------
    source_STK_backward_row = source_STK_backward_row + 1;
    des_Math_backward_row = des_Math_backward_row + 1;    
end
%output
output_Matching_distance = Matching_distance;
end

