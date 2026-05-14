function [output_Select_ISLs_for_Sats_row] = Determine_ISLs_for_STK_Sats(STK_Sats_for_ISL_data,start_sat_num,objNames)
%DETERMINE_ISLS_FOR_STK_SATS 此处显示有关此函数的摘要
%   此处显示详细说明
[row,column] = size(STK_Sats_for_ISL_data);
Select_ISLs_for_Sats_row = cell(row,column);
Select_ISLs_for_Sats_row(:,1) = STK_Sats_for_ISL_data(:,1);
for k = 1:row
    Select_ISLs = STK_Sats_for_ISL_data{k,2};
    Sat_row_for_ISLs = zeros(size(Select_ISLs,1),size(Select_ISLs,2));
    for m = 1:size(Select_ISLs,1)
        Sat_row_for_ISLs(m,1) = find_the_Sat_row(Select_ISLs{m,1},start_sat_num,objNames);
        Sat_row_for_ISLs(m,2) = find_the_Sat_row(Select_ISLs{m,2},start_sat_num,objNames);
    end
    %-------storage-----
    Select_ISLs_for_Sats_row{k,2} = Sat_row_for_ISLs;
end
%output
output_Select_ISLs_for_Sats_row = Select_ISLs_for_Sats_row;
end

