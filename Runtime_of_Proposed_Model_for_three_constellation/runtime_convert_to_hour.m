function [output_res_data] = runtime_convert_to_hour(input_data)
%RUNTIME_CONVERT_TO_HOUR 此处显示有关此函数的摘要
%   此处显示详细说明

[row,column] = size(input_data);
res_data = zeros(row,column);

for k = 1:column
    res_data(1,k) = input_data(1,k)/3600;% seconds--->hour
end
%output
output_res_data = res_data;
end

