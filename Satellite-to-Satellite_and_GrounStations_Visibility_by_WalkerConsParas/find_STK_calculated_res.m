function [outputA_corresponding_row] = find_STK_calculated_res(Sat_name_str,STK_Calc_Result)
%FIND_STK_CALCULATED_RES 此处显示有关此函数的摘要
%   此处显示详细说明
for k = 1:size(STK_Calc_Result,1)
    if contains(STK_Calc_Result{k,1},Sat_name_str)
        corresponding_row = k;
        break;
    end
end
%output
outputA_corresponding_row = corresponding_row;
end

