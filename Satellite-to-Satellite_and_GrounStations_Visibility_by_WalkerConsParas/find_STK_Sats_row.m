function [output_Select_STK_Sats_row] = find_STK_Sats_row(STK_Sats_for_ISL_data,start_sat_num,objNames)
%FIND_STK_SATS_ROW 此处显示有关此函数的摘要
%   此处显示详细说明
%,start_sat_num,objNames

Select_STK_Sats_row = zeros(size(STK_Sats_for_ISL_data,1),1);

for k = 1:size(STK_Sats_for_ISL_data,1)
    tmp_sat_string = STK_Sats_for_ISL_data{k,1};
    for row = start_sat_num:size(objNames,1)
        if contains(objNames{row,1},tmp_sat_string)
            Corresponding_row = row;
            break;
        end
    end
    Select_STK_Sats_row(k,1) = Corresponding_row;
end

%output
output_Select_STK_Sats_row = Select_STK_Sats_row;
end

