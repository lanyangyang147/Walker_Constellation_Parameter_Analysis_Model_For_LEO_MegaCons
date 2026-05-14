function [output_Valid_ISLs_distance_data] = Filter_Invalid_ISL_distance(All_ISLs_distance_data)
%FILTER_INVALID_ISL_DISTANCE 此处显示有关此函数的摘要
%   此处显示详细说明
STK_distance_column = 5;
Mathematice_distance_column = 6;
Valid_ISLs_distance_data = cell(size(All_ISLs_distance_data,1),size(All_ISLs_distance_data,2));
count = 0;

for k = 1:size(All_ISLs_distance_data,1)
    row1 = size(All_ISLs_distance_data{k,STK_distance_column},1);
    row2 = size(All_ISLs_distance_data{k,Mathematice_distance_column},1);
    if (row1 ~= 1) && (row2 ~= 2)
        count = count + 1;
        Valid_ISLs_distance_data(count,:) = All_ISLs_distance_data(k,:);
    end
end

Valid_ISLs_distance_data = Valid_ISLs_distance_data(1:count,:);

%output
output_Valid_ISLs_distance_data = Valid_ISLs_distance_data;
end

