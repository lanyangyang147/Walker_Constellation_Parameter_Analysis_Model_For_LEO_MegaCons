function [output_ISL_Result_in_STK] = preprocess_ISLs_data_output_from_STK(source_data)
%PREPROCESS_ISLS_DATA_OUTPUT_FROM_STK 此处显示有关此函数的摘要
%   此处显示详细说明
[row,column] = size(source_data);
ISL_Result_in_STK = cell(row,column);
ISL_Result_in_STK(:,1) = source_data(:,1);

for k = 1:size(source_data,1)
    ISL_Result_in_STK{k,2} = preprocess_STK_ISLs_data(source_data{k,2});
end

%output
output_ISL_Result_in_STK = ISL_Result_in_STK;
end

