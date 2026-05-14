function [output_flag,output_corresponding_row] = find_time_corresponding_data_in_STK(proposed_time,STK_Result)
%FIND_TIME_CORRESPONDING_DATA_IN_STK 此处显示有关此函数的摘要
%   此处显示详细说明
flag = 0;
corresponding_row = 0;
for k = 1:size(STK_Result,1)
%     tmp_time = floor(STK_Result(k,1));
    tmp_time = round(STK_Result(k,1));
    if tmp_time == proposed_time
        flag = 1;
        corresponding_row = k;
        break;
    end
end
%output
output_flag = flag;
output_corresponding_row = corresponding_row;
end

