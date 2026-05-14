function [output_STK_Sats_for_accuracy] = find_corresponding_STK_Sats_data(Sats_for_accuracy,STK_all_Result)
%FIND_CORRESPONDING_SATS_DATA 此处显示有关此函数的摘要
%   此处显示详细说明
[row,column] = size(STK_all_Result);
STK_Sats_for_accuracy = cell(row,column);

for k = 1:size(Sats_for_accuracy,1)
    sat1_name_str = Sats_for_accuracy{k,1};
    sat2_name_str = Sats_for_accuracy{k,2};
    for m = 1:size(STK_all_Result,1)
        if contains(STK_all_Result{m,1},sat1_name_str) && contains(STK_all_Result{m,1},sat2_name_str)
            corresponding_row = m;
            break;
        end
    end
    STK_Sats_for_accuracy(k,:) = STK_all_Result(corresponding_row,:);
end

%output
output_STK_Sats_for_accuracy = STK_Sats_for_accuracy;
end

