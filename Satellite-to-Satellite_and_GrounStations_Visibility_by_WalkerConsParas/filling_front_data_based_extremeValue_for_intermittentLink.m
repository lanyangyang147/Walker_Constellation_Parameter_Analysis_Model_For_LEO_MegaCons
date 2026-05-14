function [output_Matching_distance] = filling_front_data_based_extremeValue_for_intermittentLink(STK_extremeValue_row,Mathematics_extremeValue_row,STK_distance,STK_extreme_min_start_row,Math_extreme_min_start_row,Matching_distance)
%FILLING_THE_FRONT_DATA_BASED_EXTREMEVALUE 此处显示有关此函数的摘要
%   此处显示详细说明
%STK_extremeValue_row,Mathematics_extremeValue_row,STK_distance,All_Mathematics_AND_STK_distance

%STK_extremeValue_row,Mathematics_extremeValue_row,STK_distance,Matching_distance
%-----Upward-----
source_STK_upward_row = STK_extremeValue_row;
des_Math_upward_row = Mathematics_extremeValue_row;
while 1
    Matching_distance(des_Math_upward_row,3) = STK_distance(source_STK_upward_row,1);
    Matching_distance(des_Math_upward_row,4) = STK_distance(source_STK_upward_row,2);
    %------break--------
    %,
    if source_STK_upward_row == STK_extreme_min_start_row || des_Math_upward_row == Math_extreme_min_start_row
        break;
    end
    %------update variable--------
    source_STK_upward_row = source_STK_upward_row - 1;
    des_Math_upward_row = des_Math_upward_row - 1;    
end
%output
output_Matching_distance = Matching_distance;
end

