function [output_STK_result] = preprocess_ISLs_data(source_data,Orbital_period,Num_of_Orbital_Period)
%PREPROCESS_SGLS 此处显示有关此函数的摘要
%   此处显示详细说明
STK_result = cell(size(source_data,1),size(source_data,2));

time_column = 6;
elevation_column = 8;
distance_column = 9;

for k = 1:size(source_data,1)
    tmp_Result = cell2mat([source_data(k,time_column) source_data(k,elevation_column) source_data(k,distance_column)]);
    ISL_result = Filter_effect_data_for_ISL(Orbital_period,Num_of_Orbital_Period,tmp_Result);
    %-----storage----
    STK_result{k,1} = source_data{k,1};
    STK_result{k,2} = ISL_result;
end
%output
output_STK_result = STK_result(:,1:2);
end

