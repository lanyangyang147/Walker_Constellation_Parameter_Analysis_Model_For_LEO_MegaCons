function [output_row] = determine_row_based_value(Value,Distance_data)
%DETERMINE_ROW_BASED_VALUE 此处显示有关此函数的摘要
%   此处显示详细说明

for k = 1:size(Distance_data,1)
    if Value == Distance_data(k,2)
        row = k;
        break;
    end
end

%output
output_row = row;
end

